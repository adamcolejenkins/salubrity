json.array!(@surveys) do |survey|
  json.extract! survey, :id, :title, :description, :guid, :status, :intro_id, :outro_id, :deleted_at, :created_at, :updated_at
end
