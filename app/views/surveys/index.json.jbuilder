json.array!(@surveys) do |survey|
  json.extract! survey, :id, :team_id, :fields, :title, :description, :guid, :status, :created_at, :updated_at
end
