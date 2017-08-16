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