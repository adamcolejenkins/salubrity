json.extract! @survey, :id, :title, :description, :guid, :intro_id, :outro_id, :status, :deleted_at, :created_at, :updated_at
json.fields @survey.fields, partial: 'api/fields/show', as: :field