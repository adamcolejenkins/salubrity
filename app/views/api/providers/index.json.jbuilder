json.array!(@api_providers) do |api_provider|
  json.extract! api_provider, :id
  json.url api_provider_url(api_provider, format: :json)
end
