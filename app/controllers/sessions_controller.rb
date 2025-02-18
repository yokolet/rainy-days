class SessionsController < ApplicationController
  def prepare
    provider = params[:provider]
    state = generate_state
    verifier = generate_verifier
    code_challenge = generate_code_challenge(verifier)
    pkce = {
      google_oauth2: {
        authorization_url: 'https://accounts.google.com/o/oauth2/auth',
        params: {
          redirect_uri: Rails.application.credentials.oauth.google_oauth2.redirect_uri,
          client_id: Rails.application.credentials.oauth.google_oauth2.client_id.strip,
          response_type: 'code',
          code_challenge: code_challenge,
          code_challenge_method: 'S256',
          scope: 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile',
          state: state,
        }
      },
      github: {
        authorization_url: 'https://github.com/login/oauth/authorize',
        params: {
          redirect_uri: Rails.application.credentials.oauth.github.redirect_uri,
          client_id: Rails.application.credentials.oauth.github.client_id.strip,
          response_type: 'code',
          code_challenge: code_challenge,
          code_challenge_method: 'S256',
          scope: 'user',
          state: state,
        }
      },
      gitlab: {
        authorization_url: 'https://gitlab.example.com/oauth/authorize',
        params: {
          redirect_uri: Rails.application.credentials.oauth.gitlab.redirect_uri,
          client_id: Rails.application.credentials.oauth.gitlab.client_id.strip,
          response_type: 'code',
          code_challenge: code_challenge,
          code_challenge_method: 'S256',
          scope: 'read_user',
          state: state,
        }
      },
    }
    session[state] = verifier
    session[:provider] = provider
    render json: pkce[provider.to_sym].to_json
  rescue => error
    Rails.logger.error(error.to_s)
  end

  def create
    state, code, scope = params[:state], params[:code], params[:scope]
    puts("state: #{state}, code: #{code}, scope: #{scope}")
    verifier = session[state]
    puts("verifier: #{verifier}")
    # @user = User.from_omniauth(request.env['omniauth.auth'])
    # if @user.persisted?
    #   session[:user_id] = @user.id
    #   redirect_path = request.env['omniauth.origin'] || dashboard_path
    #   redirect_to redirect_path, notice: "Logged in as #{@user.name}"
    # else
    #   redirect_to root_url, alert: "Failure"
    # end
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

  def generate_code_challenge(code_verifier)
    Digest::SHA256.base64digest(code_verifier).tr("+/", "-_").tr("=", "")
  end

  def generate_state
    SecureRandom.uuid
  end

end
