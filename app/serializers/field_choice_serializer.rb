class FieldChoiceSerializer < ActiveModel::Serializer
  attributes :id, :field_id, :label, :key, :priority
end
