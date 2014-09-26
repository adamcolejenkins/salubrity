class SurveySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :guid, :fields, :logo_path, :status, :scheduled, :scheduled_start, :scheduled_stop
  has_many :fields
end
