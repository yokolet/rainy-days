# frozen_string_literal: true

def github_oauth_params
  {
    authorization: {
      endpoint: 'https://github.com/login/oauth/authorize',
      params: {
        redirect_uri: Rails.application.credentials.oauth.github.redirect_uri.strip,
        client_id: Rails.application.credentials.oauth.github.client_id.strip,
        response_type: 'code',
        scope: 'user',
      }
    },
    token: {
      endpoint: {
        url: 'https://github.com',
        path: '/login/oauth/access_token',
      },
      params: {
        redirect_uri: Rails.application.credentials.oauth.github.redirect_uri.strip,
        client_id: Rails.application.credentials.oauth.github.client_id.strip,
        client_secret: Rails.application.credentials.oauth.github.client_secret.strip,
        grant_type: 'authorization_code'
      },
    },
    user: {
      endpoint: {
        url: 'https://api.github.com',
        path: '/user',
      },
    },
    user_data: {
      username: :login,
      email: :email,
      image: :avatar_url,
    },
  }
end
