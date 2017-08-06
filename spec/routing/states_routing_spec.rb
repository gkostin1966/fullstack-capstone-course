require "rails_helper"

RSpec.describe StatesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/api/states").to route_to("states#index", format: :json)
    end

    xit "routes to #new" do
      expect(:get => "/api/states/new").to route_to("states#new", format: :json)
    end

    it "routes to #show" do
      expect(:get => "/api/states/1").to route_to("states#show", format: :json, :id => "1")
    end

    xit "routes to #edit" do
      expect(:get => "/api/states/1/edit").to route_to("states#edit", format: :json, :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/api/states").to route_to("states#create", format: :json)
    end

    it "routes to #update via PUT" do
      expect(:put => "/api/states/1").to route_to("states#update", format: :json, :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/api/states/1").to route_to("states#update", format: :json, :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/api/states/1").to route_to("states#destroy", format: :json, :id => "1")
    end

  end
end
