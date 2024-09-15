require 'rails_helper'

RSpec.describe "Seats", type: :request do
  describe "GET /select" do
    it "returns http success" do
      get "/seats/select"
      expect(response).to have_http_status(:success)
    end
  end

end
