json.array!(@surveys) do |survey|
  json.extract! survey, :id, :title, :description, :guid, :status
end