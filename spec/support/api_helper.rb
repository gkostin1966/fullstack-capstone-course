module ApiHelper
  def parsed_body
    JSON.parse(response.body)
  end

  def jpost(path, params={}, headers={})
    headers = headers.merge('Content-Type' => 'application/json') if params.present?
    post path, params.to_json, headers
  end
end