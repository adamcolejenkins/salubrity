json.extract! @clinic, :id, :title, :guid, :address, :address2, :city, :state, :zip, :phone, :survey, :providers, :created_at, :updated_at
# json.survey @clinic.survey, partial: 'api/survey/show', as: :survey