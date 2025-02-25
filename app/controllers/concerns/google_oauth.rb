# frozen_string_literal: true

def google_oauth_params
  {
    authorization: {
      endpoint: 'https://accounts.google.com/o/oauth2/auth',
      params: {
        redirect_uri: Rails.application.credentials.oauth.google.redirect_uri.strip,
        client_id: Rails.application.credentials.oauth.google.client_id.strip,
        response_type: 'code',
        code_challenge_method: 'S256',
        scope: 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile',
      }
    },
    token: {
      endpoint: {
        url: 'https://oauth2.googleapis.com',
        path: '/token',
      },
      params: {
        redirect_uri: Rails.application.credentials.oauth.google.redirect_uri.strip,
        client_id: Rails.application.credentials.oauth.google.client_id.strip,
        client_secret: Rails.application.credentials.oauth.google.client_secret.strip,
        grant_type: 'authorization_code'
      },
    },
    user: {
      endpoint: {
        url: 'https://www.googleapis.com',
        path: '/oauth2/v3/userinfo',
      },
    },
    user_data: {
      username: :given_name,
      email: :email,
      image: :picture,
    }
  }
end
