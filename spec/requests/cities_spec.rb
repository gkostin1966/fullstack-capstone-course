require 'rails_helper'

RSpec.describe "Cities", type: :request do
  include_context 'db_cleanup_each', :transaction

  describe '#index' do
    let!(:cities) { (1..5).map { |i| FactoryGirl.create(:city) } }

    it do
      get cities_path, { sample1: 'param', sample2: 'param' }, { 'Accept' => 'application/json' }

      expect(request.method).to eq('GET')
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json')
      expect(response['X-Frame-Options']).to eq 'SAMEORIGIN'

      payload = parsed_body
      expect(payload.count).to eq(cities.count)
      expect(payload.map{ |f| f['name'] }).to include(*cities.map{ |f| f[:name] })
    end
  end

  describe '#create' do
    let(:city_state) { FactoryGirl.attributes_for(:city) }

    it do
      jpost cities_path, city_state
      expect(response).to have_http_status(:created)
      expect(response.content_type).to eq('application/json')

      payload = parsed_body
      expect(payload).to have_key('id')
      expect(payload).to have_key('name')
      expect(payload["name"]).to eq(city_state[:name])
      expect(payload).to have_key('created_at')
      expect(payload).to have_key('updated_at')

      expect(City.find(payload["id"]).name).to eq(city_state[:name])
    end
  end

  describe '#show' do
    let(:city) { FactoryGirl.create(:city) }

    it do
      get city_path(city.id)
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json')

      payload = parsed_body
      expect(payload).to have_key('id')
      expect(payload['id']).to eq(city.id)
      expect(payload).to have_key('name')
      expect(payload['name']).to eq(city.name)
      expect(payload).to have_key('created_at')
      expect(payload['created_at']).to eq(city.created_at.to_json.gsub(/"/,''))
      expect(payload).to have_key('updated_at')
      expect(payload['updated_at']).to eq(city.updated_at.to_json.gsub(/"/,''))
    end
  end

  describe '#update' do
    let(:city) { FactoryGirl.create(:city) }
    let(:new_name) { "testing" }

    it do
      expect(city.name).not_to eq(new_name)

      jput city_path(city.id), { name: new_name }
      expect(response).to have_http_status(:no_content)
      expect(City.find(city.id).name).to eq(new_name)
    end
  end

  describe "#destroy" do
    let(:city) { FactoryGirl.create(:city) }

    it do
      head city_path(city.id)
      expect(response).to have_http_status(:ok)

      delete city_path(city.id)
      expect(response).to have_http_status(:no_content)

      head city_path(city.id)
      expect(response).to have_http_status(:not_found)
    end
  end
end
