class SessionsController < ApplicationController
  PROVIDERS = {
    "google" => :google,
    "github" => :github,
    "gitlab" => :gitlab,
  }

  def prepare
    provider = PROVIDERS[params[:provider]]
    state = generate_state
    verifier = generate_verifier
    code_challenge = generate_code_challenge(verifier)
    Rails.cache.fetch(state) { verifier }

    render json: auth_params(provider, code_challenge, state).to_json
  rescue => error
    Rails.logger.error(error.to_s)
  end

  def create
    state, code, provider = params[:state], params[:code], PROVIDERS[params[:provider]]
    verifier = Rails.cache.fetch(state)
    access_token_params = get_access_token(provider, verifier, code)
    user_info_params = get_user_info(provider, access_token_params[:access_token])
    user_data = extract_user_data(provider, user_info_params)
    if User.find_or_initialize_by(email: user_data[:email]).
      update(uid: user_data[:uid], provider: user_data[:provider], image: user_data[:image])
    else
      raise('Failed to find or update user')
    end

    cookies["rainy-days"] = {
      value: user_data.to_json,
      httponly: false
    }
    redirect_to root_path, notice: "Logged In"
  rescue => e
    Rails.logger.error(e.to_s)
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out"
  end

  def failure
    redirect_to root_path, alert: "Failure"
  end

  private

  def generate_verifier(length: 48)
    SecureRandom.base64((length * 3) / 4).tr("+/", "-_").tr("=", "")
  end

  def generate_code_challenge(verifier)
    Digest::SHA256.base64digest(verifier).tr("+/", "-_").tr("=", "")
  end

  def generate_state
    SecureRandom.uuid
  end

  def auth_params(provider, code_challenge, state)
    auth_params = Rails.application.config.rainy_days_oauth[provider][:authorization]
    provider != :github ?
      auth_params.merge({params: auth_params[:params].merge({code_challenge: code_challenge, state: state})}) :
      auth_params.merge({params: auth_params[:params].merge({state: state})})
  end

  def token_params(provider, verifier, code)
    token_params = Rails.application.config.rainy_days_oauth[provider][:token]
    provider != :github ?
      token_params.merge({params: token_params[:params].merge({code_verifier: verifier, code: code})}) :
      token_params.merge({params: token_params[:params].merge({code: code})})
  end

  def get_access_token(provider, verifier, code)
    params = token_params(provider, verifier, code)

    conn = Faraday.new(
      url: params[:endpoint][:url],
      headers: {
        'Content-Type' => 'application/x-www-form-urlencoded',
        'Accept' => 'application/json',
      }
    )
    response = conn.post(params[:endpoint][:path],
                         URI.encode_www_form(params[:params]))
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_user_info(provider, access_token)
    user_params = Rails.application.config.rainy_days_oauth[provider][:user]

    conn = Faraday.new(
      url: user_params[:endpoint][:url],
      headers: {
        'Authorization' => "Bearer #{access_token}",
      }
    )
    response = conn.get(user_params[:endpoint][:path])
    JSON.parse(response.body, symbolize_names: true)
  end

  def extract_user_data(provider, user_info)
    keys = Rails.application.config.rainy_days_oauth[provider][:user_data]

    user = keys.map do |key, value|
      [key, user_info[value]]
    end.to_h
    user.merge({provider: provider})
  end
end
