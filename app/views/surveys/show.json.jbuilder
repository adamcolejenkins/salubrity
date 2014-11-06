json.extract! @survey, :id, :team_id, :fields, :title, :description, :guid, :status, :created_at, :updated_at
json.fields @survey.fields, partial: 'api/fields/show', as: :field