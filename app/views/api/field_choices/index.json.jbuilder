json.array!(@api_field_choices) do |api_field_choice|
  json.extract! api_field_choice, :id
  json.url api_field_choice_url(api_field_choice, format: :json)
end
