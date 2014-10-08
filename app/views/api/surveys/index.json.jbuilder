json.array!(@api_surveys) do |api_survey|
  json.extract! api_survey, :id
  json.url api_survey_url(api_survey, format: :json)
end
