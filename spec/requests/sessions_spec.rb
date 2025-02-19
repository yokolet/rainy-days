require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /sign_in/:provider" do
    it "returns pkce params for google oauth2" do
      get "/sign_in/google_oauth2"
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
    it "is redirected after a successful process" do
      session = { "some-state" => "verifier", :provider => "google_oauth2" }
      allow_any_instance_of(SessionsController).to receive(:session).and_return(session)
      stub_request(:post, "https://oauth2.googleapis.com/token").
        with(
          body: {
            "client_id" => Rails.application.credentials.oauth.google_oauth2.client_id.strip,
            "client_secret" => Rails.application.credentials.oauth.google_oauth2.client_secret.strip,
            "code" => "long-alpha-numeric-code",
            "code_verifier" => "verifier",
            "grant_type" => "authorization_code",
            "redirect_uri" => "http://localhost:3906/auth/google_oauth2/callback"
          },
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Type'=>'application/x-www-form-urlencoded',
            'User-Agent'=>'Faraday v2.12.2'
          }).
        to_return(status: 200,
                  body: {
                    "access_token": "de6780bc506a0446309bd9362820ba8aed28aa506c71eedbe1c5c4f9dd350e54",
                    "token_type": "bearer",
                    "expires_in": 7200,
                    "refresh_token": "8257e65c97202ed1726cf9571600918f3bffb2544b26e00a61df9897668c33a1",
                  }.to_json,
                  headers: {})
      get "/auth/google_oauth2/callback",
          params: {
            "state" => "some-state",
            "code" => "long-alpha-numeric-code",
            "scope" => "scopeA scopeB",
            "authuser" => "0",
            "prompt" => "consent"
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
