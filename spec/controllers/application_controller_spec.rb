require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  include ApiHelper

  context 'rescue_from exception' do
    controller do
      attr_accessor :the_exception
      def trigger
        raise @the_exception
      end
    end
    before do
      routes.draw { get "trigger" => "anonymous#trigger" }
    end

    it "ActiveRecord::RecordNotFound with response not found" do
      controller.the_exception = ActiveRecord::RecordNotFound.new
      get :trigger, id: :bad_id
      expect(response).to have_http_status(:not_found)
      expect(response.content_type).to eq('application/json')

      payload = parsed_body
      expect(payload).to have_key('errors')
      expect(payload['errors']).to have_key('full_messages')
      expect(payload['errors']['full_messages'][0]).to include('cannot', 'bad_id')
    end

    it "Mongoid::Errors::DocumentNotFound with response not found" do
      class Klass
        include Mongoid::Document
        include Mongoid::Timestamps
      end
      controller.the_exception = Mongoid::Errors::DocumentNotFound.new(Klass, [:bad_id])
      get :trigger, id: :bad_id
      expect(response).to have_http_status(:not_found)
      expect(response.content_type).to eq('application/json')

      payload = parsed_body
      expect(payload).to have_key('errors')
      expect(payload['errors']).to have_key('full_messages')
      expect(payload['errors']['full_messages'][0]).to include('cannot', 'bad_id')
    end
  end
end
