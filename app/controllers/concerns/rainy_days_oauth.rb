# frozen_string_literal: true

require_relative "./google_oauth.rb"
require_relative "./github_oauth.rb"
require_relative "./gitlab_oauth.rb"

PROVIDERS = {
  "google" => :google,
  "github" => :github,
  "gitlab" => :gitlab
}

ALL_AUTH_PARAMS = {
  google: Class.new.extend(GoogleOauth).google_oauth_params,
  github: Class.new.extend(GithubOauth).github_oauth_params,
  gitlab: Class.new.extend(GitlabOauth).gitlab_oauth_params
}

module RainyDaysOauth
  def auth_params(provider, code_challenge, state)
    auth_params = ALL_AUTH_PARAMS[provider][:authorization]
    provider != :github ?
      auth_params.merge({ params: auth_params[:params].merge({ code_challenge: code_challenge, state: state }) }) :
      auth_params.merge({ params: auth_params[:params].merge({ state: state }) })
  end

  def token_params(provider, verifier, code)
    token_params = ALL_AUTH_PARAMS[provider][:token]
    provider != :github ?
      token_params.merge({ params: token_params[:params].merge({ code_verifier: verifier, code: code }) }) :
      token_params.merge({ params: token_params[:params].merge({ code: code }) })
  end

  def user_info_params(provider)
    ALL_AUTH_PARAMS[provider][:user]
  end

  def key_params(provider)
    ALL_AUTH_PARAMS[provider][:user_data]
  end
end
