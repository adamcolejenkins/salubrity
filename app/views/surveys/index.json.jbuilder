json.array!(@surveys) do |survey|
  json.extract! survey, :id, :team_id, :title, :description, :guid, :status
  json.url survey_url(survey, format: :json)
end
