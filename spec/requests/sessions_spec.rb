require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /create" do
    it "returns http success" do
      session = { "some-state" => "verifier" }
      allow_any_instance_of(SessionsController).to receive(:session).and_return(session)
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
