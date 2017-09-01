require 'rails_helper'

RSpec.describe "States", type: :request do
  include_context 'db_cleanup_each'

  describe '#index' do
    it_should_behave_like 'resource#index', :state do
      let(:response_check) do
        expect(payload.map{|f|f['name']}).to eq(resources.map{|f|f[:name]})
      end
    end
  end

  describe '#create' do
    it_should_behave_like 'resource#create', :state do
      let(:response_check) do
        expect(payload).to have_key('id')
        expect(payload).to have_key('name')
        expect(payload["name"]).to eq(resource_state[:name])
        expect(payload).to have_key('created_at')
        expect(payload).to have_key('updated_at')
        expect(State.find(payload["id"]).name).to eq(resource_state[:name])
      end
    end
  end

  describe '#show' do
    it_should_behave_like 'resource#show', :state do
      let(:response_check) do
        expect(payload).to have_key('id')
        expect(payload['id']).to eq(resource.id.to_s)
        expect(payload).to have_key('name')
        expect(payload['name']).to eq(resource.name)
        expect(payload).to have_key('created_at')
        expect(payload['created_at']).to eq(resource.created_at.to_json.gsub(/"/,''))
        expect(payload).to have_key('updated_at')
        expect(payload['updated_at']).to eq(resource.updated_at.to_json.gsub(/"/,''))
      end
    end
  end

  describe '#update' do
    new_name = "testing"
    it_should_behave_like 'resource#update', :state, { name: new_name } do
      let(:response_check) do
        expect(State.find(resource.id).name).to eq(new_name)
      end
    end
  end

  describe '#destroy' do
    it_should_behave_like 'resource#destroy', :state
  end
end
