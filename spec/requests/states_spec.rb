require 'rails_helper'

RSpec.describe "States", type: :request do
  def parsed_body
    JSON.parse(response.body)
  end

  before(:all) { State.delete_all }
  after(:each) { State.delete_all }

  describe "GET /api/states" do
    let!(:state) { State.create(name: 'name') }
    before do
      get states_path
    end
    it "exposes REST API read" do
      expect(response).to have_http_status(:ok)
      expect(parsed_body[0]["id"]).to eq(state.id.to_s)
      expect(parsed_body[0]["name"]).to eq(state.name)
      expect(parsed_body[0]["created_at"]).to eq(state.created_at.to_json.gsub(/"/,''))
      expect(parsed_body[0]["updated_at"]).to eq(state.updated_at.to_json.gsub(/"/,''))
    end
  end
end
