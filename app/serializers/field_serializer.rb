class FieldSerializer < ActiveModel::Serializer
  attributes :id, :survey_id, :label, :field_type, :field_size, :layout, :display_as, :instructions, :range_min, :range_max, :increment, :field_choices, :required, :visibility, :predefined_value, :priority
  has_many :field_choices
end
