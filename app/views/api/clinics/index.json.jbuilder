json.array!(@api_clinics) do |api_clinic|
  json.extract! api_clinic, :id
  json.url api_clinic_url(api_clinic, format: :json)
end
