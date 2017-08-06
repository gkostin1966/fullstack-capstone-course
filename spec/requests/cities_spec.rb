require 'rails_helper'

RSpec.describe "Cities", type: :request do
  def parsed_body
    JSON.parse(response.body)
  end

  before(:all) { City.delete_all }
  after(:each) { City.delete_all }

  describe "GET /api/cities" do
    let!(:city) { City.create(name: 'name') }
    before do
      get cities_path
    end
    it "exposes REST API read" do
      expect(response).to have_http_status(:ok)
      expect(parsed_body[0]["id"]).to eq(city.id)
      expect(parsed_body[0]["name"]).to eq(city.name)
      expect(parsed_body[0]["created_at"]).to eq(city.created_at.to_json.gsub(/"/,''))
      expect(parsed_body[0]["updated_at"]).to eq(city.updated_at.to_json.gsub(/"/,''))
    end
  end
end
