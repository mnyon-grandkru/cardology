require 'rails_helper'

RSpec.describe "Celestials", type: :request do
  describe "GET /celestials" do
    it "works! (now write some real specs)" do
      get celestials_path
      expect(response).to have_http_status(200)
    end
  end
end
