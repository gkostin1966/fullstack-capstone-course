module ApiHelper
  def parsed_body
    JSON.parse(response.body)
  end

=begin
  def jpost(path, params={}, headers={})
    headers = headers.merge('Content-Type' => 'application/json') if params.present?
    post path, params.to_json, headers
  end

  def jput(path, params={}, headers={})
    headers = headers.merge('Content-Type' => 'application/json') if params.present?
    put path, params.to_json, headers
  end
=end

  # automates the passing of payload bodies as json
  ['post', 'put'].each do |http_method_name|
    define_method("j#{http_method_name}") do |path, params={}, headers={}|
      headers = headers.merge('Content-Type' => 'application/json') if params.present?
      self.send(http_method_name, path, params.to_json, headers)
    end
  end
end

def signup registration, status = :ok
  jpost user_registration_path, registration
  expect(response).to have_http_status(status)
end

RSpec.shared_examples 'resource#index' do |model|
  let!(:resources) { (1..5).map { |idx| FactoryGirl.create(model) } }
  let(:payload) { parsed_body }

  it "indexes #{model}" do
    get send("#{model}s_path"), {}, {"Accept"=>"application/json"}
    expect(response).to have_http_status(:ok)
    expect(response.content_type).to eq('application/json')
    expect(payload.count).to eq(resources.count)
    response_check  if respond_to?(:response_check)
  end
end

RSpec.shared_examples 'resource#create' do |model|
  let(:resource_state) { FactoryGirl.attributes_for(model) }
  let(:payload) { parsed_body }

  it "creates #{model}" do
    jpost send("#{model}s_path"), resource_state
    expect(response).to have_http_status(:created)
    expect(response.content_type).to eq('application/json')
    response_check  if respond_to?(:response_check)
  end
end

RSpec.shared_examples 'resource#show' do |model|
  let(:resource) { FactoryGirl.create(model) }
  let(:payload) { parsed_body }

  it "shows #{model}" do
    get send("#{model}_path", resource.id)
    expect(response).to have_http_status(:ok)
    expect(response.content_type).to eq('application/json')
    response_check  if respond_to?(:response_check)
  end
end

RSpec.shared_examples 'resource#update' do |model, attrs|
  let(:resource) { FactoryGirl.create(model) }
  it "updates #{model}" do
    attrs.each do |key, value|
      expect(resource[key]).not_to eq(value)
    end
    jput send("#{model}_path", resource.id), attrs
    expect(response).to have_http_status(:no_content)
    response_check  if respond_to?(:response_check)
  end
end

RSpec.shared_examples 'resource#destroy' do |model|
  let(:resource) { FactoryGirl.create(model) }

  it "destroys #{model}" do
    head send("#{model}_path", resource.id)
    expect(response).to have_http_status(:ok)

    delete send("#{model}_path", resource.id)
    expect(response).to have_http_status(:no_content)

    head send("#{model}_path", resource.id)
    expect(response).to have_http_status(:not_found)
  end
end
