class SurveySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :guid, :fields, :intro_id, :outro_id, :logo_path, :status, :scheduled, :scheduled_start, :scheduled_stop
  has_many :fields
end
