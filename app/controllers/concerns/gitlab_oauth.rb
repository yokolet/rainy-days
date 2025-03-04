# frozen_string_literal: true

module GitlabOauth
  def gitlab_oauth_params
    {
      authorization: {
        endpoint: "https://gitlab.com/oauth/authorize",
        params: {
          redirect_uri: Rails.application.credentials.oauth.gitlab.redirect_uri.strip,
          client_id: Rails.application.credentials.oauth.gitlab.client_id.strip,
          response_type: "code",
          code_challenge_method: "S256",
          scope: "read_user"
        }
      },
      token: {
        endpoint: {
          url: "https://gitlab.com",
          path: "/oauth/token"
        },
        params: {
          redirect_uri: Rails.application.credentials.oauth.gitlab.redirect_uri.strip,
          client_id: Rails.application.credentials.oauth.gitlab.client_id.strip,
          client_secret: Rails.application.credentials.oauth.gitlab.client_secret.strip,
          grant_type: "authorization_code"
        }
      },
      user: {
        endpoint: {
          url: "https://gitlab.com",
          path: "/api/v4/user"
        }
      },
      user_data: {
        username: :username,
        email: :email,
        image: :avatar_url
      }
    }
  end
end
