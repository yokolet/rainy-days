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
    pkce_params = {
      google: {
        authorization_url: 'https://accounts.google.com/o/oauth2/auth',
        params: {
          redirect_uri: Rails.application.credentials.oauth.google.redirect_uri.strip,
          client_id: Rails.application.credentials.oauth.google.client_id.strip,
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
          redirect_uri: Rails.application.credentials.oauth.github.redirect_uri.strip,
          client_id: Rails.application.credentials.oauth.github.client_id.strip,
          response_type: 'code',
          scope: 'user',
          state: state,
        }
      },
      gitlab: {
        authorization_url: 'https://gitlab.com/oauth/authorize',
        params: {
          redirect_uri: Rails.application.credentials.oauth.gitlab.redirect_uri.strip,
          client_id: Rails.application.credentials.oauth.gitlab.client_id.strip,
          response_type: 'code',
          code_challenge: code_challenge,
          code_challenge_method: 'S256',
          scope: 'read_user',
          state: state,
        }
      },
    }
    Rails.cache.fetch(state) { verifier }
    render json: pkce_params[provider].to_json
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

  def get_access_token(provider, verifier, code)
    token_params = {
      google: {
        endpoint: {
          url: "https://oauth2.googleapis.com",
          path: "/token",
        },
        params: {
          redirect_uri: Rails.application.credentials.oauth.google.redirect_uri.strip,
          client_id: Rails.application.credentials.oauth.google.client_id.strip,
          client_secret: Rails.application.credentials.oauth.google.client_secret.strip,
          code: code,
          code_verifier: verifier,
          grant_type: 'authorization_code'
        },
      },
      github: {
        endpoint: {
          url: "https://github.com",
          path: "/login/oauth/access_token",
        },
        params: {
          redirect_uri: Rails.application.credentials.oauth.github.redirect_uri.strip,
          client_id: Rails.application.credentials.oauth.github.client_id.strip,
          client_secret: Rails.application.credentials.oauth.github.client_secret.strip,
          code: code,
          grant_type: 'authorization_code'
        },
      },
      gitlab: {
        endpoint: {
          url: "https://gitlab.com",
          path: "/oauth/token",
        },
        params: {
          redirect_uri: Rails.application.credentials.oauth.gitlab.redirect_uri.strip,
          client_id: Rails.application.credentials.oauth.gitlab.client_id.strip,
          client_secret: Rails.application.credentials.oauth.gitlab.client_secret.strip,
          code: code,
          code_verifier: verifier,
          grant_type: 'authorization_code'
        },
      }
    }

    conn = Faraday.new(
      url: token_params[provider][:endpoint][:url],
      headers: {
        'Content-Type' => 'application/x-www-form-urlencoded',
        'Accept' => 'application/json',
      }
    )
    response = conn.post(token_params[provider][:endpoint][:path],
                         URI.encode_www_form(token_params[provider][:params]))
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_user_info(provider, access_token)
    user_info_params = {
      google: {
        endpoint: {
          url: "https://www.googleapis.com",
          path: "/oauth2/v3/userinfo",
        },
      },
      github: {
        endpoint: {
          url: "https://api.github.com",
          path: "/user",
        },
      },
      gitlab: {
        endpoint: {
          url: "https://gitlab.com",
          path: "/api/v4/user",
        },
      },
    }
    conn = Faraday.new(
      url: user_info_params[provider][:endpoint][:url],
      headers: {
        'Authorization' => "Bearer #{access_token}",
      }
    )
    response = conn.get(user_info_params[provider][:endpoint][:path])
    JSON.parse(response.body, symbolize_names: true)
  end

  def extract_user_data(provider, user_info)
    keys = {
      google: {
        uid: :given_name,
        email: :email,
        image: :picture,
      },
      github: {
        uid: :login,
        email: :email,
        image: :avatar_url,
      },
      gitlab: {
        uid: :username,
        email: :email,
        image: :avatar_url,
      },
    }
    user = keys[provider].map do |key, value|
      [key, user_info[value]]
    end.to_h
    user.merge({provider: provider})
  end
end
