require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /sign_in/:provider" do
    it "returns pkce params for google oauth2" do
      get "/sign_in/google"
      expect(response.body).not_to be_nil
      expect(JSON.parse(response.body)["authorization_url"]).not_to be_nil
    end

    it "returns pkce params for github" do
      get "/sign_in/github"
      expect(response.body).not_to be_nil
      expect(JSON.parse(response.body)["authorization_url"]).not_to be_nil
    end

    it "returns pkce params for gitlab" do
      get "/sign_in/gitlab"
      expect(response.body).not_to be_nil
      expect(JSON.parse(response.body)["authorization_url"]).not_to be_nil
    end
  end

  describe "GET /auth/:provider/callback" do
    it "is redirected after a successful process with google" do
      session = { "some-state" => "verifier", :provider => "google" }
      allow_any_instance_of(SessionsController).to receive(:session).and_return(session)
      stub_request(:post, "https://oauth2.googleapis.com/token").
        with(
          body: {
            "client_id" => Rails.application.credentials.oauth.google.client_id.strip,
            "client_secret" => Rails.application.credentials.oauth.google.client_secret.strip,
            "code" => "long-alpha-numeric-code",
            "code_verifier" => nil,
            "grant_type" => "authorization_code",
            "redirect_uri" => "http://localhost:3906/auth/google/callback"
          },
          headers: {
            'Accept'=>'application/json',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Type'=>'application/x-www-form-urlencoded',
            'User-Agent'=>'Faraday v2.12.2'
          }).
        to_return(status: 200,
                  body: {
                    "access_token": "google-access-token",
                    "token_type": "bearer",
                    "expires_in": 7200,
                    "refresh_token": "google-refresh-token",
                  }.to_json,
                  headers: {})

      stub_request(:get, "https://www.googleapis.com/oauth2/v3/userinfo").
        with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>'Bearer google-access-token',
            'User-Agent'=>'Faraday v2.12.2'
          }).to_return(status: 200,
                       body: {
                         "email": Faker::Internet.email,
                         "given_name": Faker::Name.first_name,
                         "picture": Faker::Avatar.image
                       }.to_json,
                       headers: {})

      get "/auth/google/callback",
          params: {
            "state" => "some-state",
            "code" => "long-alpha-numeric-code",
            "scope" => "scopeA scopeB",
            "authuser" => "0",
            "prompt" => "consent"
          }
      expect(response).to be_redirect
    end

    it "is redirected after a successful process with github" do
      session = { "some-state" => "verifier", :provider => "github" }
      allow_any_instance_of(SessionsController).to receive(:session).and_return(session)
      stub_request(:post, "https://github.com/login/oauth/access_token").
        with(
          body: {
            "client_id" => Rails.application.credentials.oauth.github.client_id.strip,
            "client_secret" => Rails.application.credentials.oauth.github.client_secret.strip,
            "code" => "long-alpha-numeric-code",
            "grant_type" => "authorization_code",
            "redirect_uri" => "http://localhost:3906/auth/github/callback"},
          headers: {
            'Accept'=>'application/json',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Type'=>'application/x-www-form-urlencoded',
            'User-Agent'=>'Faraday v2.12.2'
          }).
        to_return(status: 200,
                  body: {
                    "access_token": "github-access-token",
                    "token_type": "bearer",
                    "scope": "user",
                  }.to_json,
                  headers: {})

      stub_request(:get, "https://api.github.com/user").
        with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>'Bearer github-access-token',
            'User-Agent'=>'Faraday v2.12.2'
          }).
        to_return(status: 200,
                       body: {
                         "email": Faker::Internet.email,
                         "login": Faker::Name.first_name,
                         "avatar_url": Faker::Avatar.image
                       }.to_json,
                       headers: {})

      get "/auth/github/callback",
          params: {
            "state" => "some-state",
            "code" => "long-alpha-numeric-code",
            "scope" => "scopeC",
          }
      expect(response).to be_redirect
    end

    it "is redirected after a successful process with gitlab" do
      session = { "some-state" => "verifier", :provider => "gitlab" }
      allow_any_instance_of(SessionsController).to receive(:session).and_return(session)
      stub_request(:post, "https://gitlab.com/oauth/token").
        with(
          body: {
            "client_id" => Rails.application.credentials.oauth.gitlab.client_id.strip,
            "client_secret" => Rails.application.credentials.oauth.gitlab.client_secret.strip,
            "code" => "long-alpha-numeric-code",
            "code_verifier" => nil,
            "grant_type" => "authorization_code",
            "redirect_uri" => "http://localhost:3906/auth/gitlab/callback"
          },
          headers: {
            'Accept'=>'application/json',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Type'=>'application/x-www-form-urlencoded',
            'User-Agent'=>'Faraday v2.12.2'
          }).
        to_return(status: 200,
                  body: {
                    "access_token": "gitlab-access-token",
                    "token_type": "bearer",
                    "expires_in": 7200,
                    "refresh_token": "gitlab-refresh-token",
                  }.to_json,
                  headers: {})

      stub_request(:get, "https://gitlab.com/api/v4/user").
        with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>'Bearer gitlab-access-token',
            'User-Agent'=>'Faraday v2.12.2'
          }).
        to_return(status: 200,
                       body: {
                         "email": Faker::Internet.email,
                         "username": Faker::Name.first_name,
                         "avatar_url": Faker::Avatar.image
                       }.to_json,
                       headers: {})

      get "/auth/gitlab/callback",
          params: {
            "state" => "some-state",
            "code" => "long-alpha-numeric-code",
            "scope" => "scopeD",
          }
      expect(response).to be_redirect
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/sessions/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
