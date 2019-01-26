require "rails_helper"

RSpec.describe CelestialsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/celestials").to route_to("celestials#index")
    end

    it "routes to #new" do
      expect(:get => "/celestials/new").to route_to("celestials#new")
    end

    it "routes to #show" do
      expect(:get => "/celestials/1").to route_to("celestials#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/celestials/1/edit").to route_to("celestials#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/celestials").to route_to("celestials#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/celestials/1").to route_to("celestials#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/celestials/1").to route_to("celestials#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/celestials/1").to route_to("celestials#destroy", :id => "1")
    end

  end
end
