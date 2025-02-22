# frozen_string_literal: true

Rails.application.config.rainy_days_oauth = {
  google: {
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
      uid: :given_name,
      email: :email,
      image: :picture,
    }
  },
  github: {
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
      uid: :login,
      email: :email,
      image: :avatar_url,
    },
  },
  gitlab: {
    authorization: {
      endpoint: 'https://gitlab.com/oauth/authorize',
      params: {
        redirect_uri: Rails.application.credentials.oauth.gitlab.redirect_uri.strip,
        client_id: Rails.application.credentials.oauth.gitlab.client_id.strip,
        response_type: 'code',
        code_challenge_method: 'S256',
        scope: 'read_user',
      }
    },
    token: {
      endpoint: {
        url: 'https://gitlab.com',
        path: '/oauth/token',
      },
      params: {
        redirect_uri: Rails.application.credentials.oauth.gitlab.redirect_uri.strip,
        client_id: Rails.application.credentials.oauth.gitlab.client_id.strip,
        client_secret: Rails.application.credentials.oauth.gitlab.client_secret.strip,
        grant_type: 'authorization_code'
      },
    },
    user: {
      endpoint: {
        url: 'https://gitlab.com',
        path: '/api/v4/user',
      },
    },
    user_data: {
      uid: :username,
      email: :email,
      image: :avatar_url,
    },
  },
}
