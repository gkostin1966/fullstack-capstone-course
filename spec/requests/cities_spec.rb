require 'rails_helper'

RSpec.describe "Cities", type: :request do
  include_context 'db_cleanup_each', :transaction

  describe "GET /api/cities" do
    let!(:cities) { (1..5).map { |i| FactoryGirl.create(:city) } }
    it "exposes REST API read" do
      get cities_path, { sample1: 'param', sample2: 'param' }, { 'Accept' => 'application/json' }

      expect(request.method).to eq('GET')
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json')
      expect(response['X-Frame-Options']).to eq 'SAMEORIGIN'

      payload = parsed_body
      expect(payload.count).to eq(cities.count)
      expect(payload.map{ |f| f['name'] }).to include(*cities.map{ |f| f[:name] })
      # expect(parsed_body[0]["id"]).to eq(city.id)
      # expect(parsed_body[0]["name"]).to eq(city.name)
      # expect(parsed_body[0]["created_at"]).to eq(city.created_at.to_json.gsub(/"/,''))
      # expect(parsed_body[0]["updated_at"]).to eq(city.updated_at.to_json.gsub(/"/,''))
    end
  end
end
