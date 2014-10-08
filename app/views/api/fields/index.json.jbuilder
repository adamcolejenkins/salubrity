json.array!(@api_fields) do |api_field|
  json.extract! api_field, :id
  json.url api_field_url(api_field, format: :json)
end
