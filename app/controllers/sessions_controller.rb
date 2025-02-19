class SessionsController < ApplicationController
  PROVIDERS = {
    "google_oauth2" => :google_oauth2,
    "github" => :github,
    "gitlab" => :gitlab,
  }

  def prepare
    provider = PROVIDERS[params[:provider]]
    state = generate_state
    verifier = generate_verifier
    code_challenge = generate_code_challenge(verifier)
    pkce_params = {
      google_oauth2: {
        authorization_url: 'https://accounts.google.com/o/oauth2/auth',
        params: {
          redirect_uri: Rails.application.credentials.oauth.google_oauth2.redirect_uri.strip,
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
          redirect_uri: Rails.application.credentials.oauth.github.redirect_uri.strip,
          client_id: Rails.application.credentials.oauth.github.client_id.strip,
          response_type: 'code',
          code_challenge: code_challenge,
          code_challenge_method: 'S256',
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
    session[state] = verifier
    session[:provider] = provider
    render json: pkce_params[provider].to_json
  rescue => error
    Rails.logger.error(error.to_s)
  end

  def create
    state, code = params[:state], params[:code]
    verifier = session[state]
    puts("verifier: #{verifier}")
    access_token_params = get_access_token(session[:provider], verifier, code)
    puts("access_token_params: #{access_token_params}")

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

  def generate_code_challenge(verifier)
    Digest::SHA256.base64digest(verifier).tr("+/", "-_").tr("=", "")
  end

  def generate_state
    SecureRandom.uuid
  end

  def get_access_token(provider, verifier, code)
    provider = provider.to_sym
    token_params = {
      google_oauth2: {
        endpoint: {
          url: "https://oauth2.googleapis.com",
          path: "/token",
        },
        params: {
          redirect_uri: Rails.application.credentials.oauth.google_oauth2.redirect_uri.strip,
          client_id: Rails.application.credentials.oauth.google_oauth2.client_id.strip,
          client_secret: Rails.application.credentials.oauth.google_oauth2.client_secret.strip,
          code: code,
          code_verifier: verifier,
          grant_type: 'authorization_code'
        }
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
          code_verifier: verifier,
          grant_type: 'authorization_code'
        }
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
        }
      }
    }

    conn = Faraday.new(
      url: token_params[provider][:endpoint][:url],
      headers: {
        'Content-Type' => 'application/x-www-form-urlencoded',
      }
    )
    response = conn.post(token_params[provider][:endpoint][:path],
                         URI.encode_www_form(token_params[provider][:params]))
    JSON.parse(response.body)
  end
end
