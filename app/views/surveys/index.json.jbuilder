json.array!(@surveys) do |survey|
  json.extract! survey, :id, :title, :description, :guid, :status, :team_id, :responses, :fields, :clinics
end
