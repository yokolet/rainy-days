# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
           Rails.application.credentials.dig(:oauth, :google, :client_id),
           Rails.application.credentials.dig(:oauth, :google, :client_secret)
  provider :github,
           Rails.application.credentials.dig(:oauth, :github, :client_id),
           Rails.application.credentials.dig(:oauth, :github, :client_secret),
           scope: 'user'
  provider :gitlab,
           Rails.application.credentials.dig(:oauth, :gitlab, :client_id),
           Rails.application.credentials.dig(:oauth, :gitlab, :client_secret),
           scope: 'read_user'
end

OmniAuth.config.allowed_request_methods = %i[get]
OmniAuth.config.silence_get_warning = true
