require 'rails_helper'

RSpec.describe "ReadMarketingPreviews", type: :request do
  before do
    Card.all.each { |card| Fabricate :interpretation, :card => card, :reading => :birth }
  end
  
  describe "GET /read_marketing_previews" do
    it "works! (now write some real specs)" do
      post birthdays_path :birthday => birthdate_parameters_from_date_picker(Fabricate.attributes_for :birthday)
      expect(response).to have_http_status(200)
    end
  end
end
