class FieldSerializer < ActiveModel::Serializer
  attributes :id, :survey_id, :label, :field_type, :field_size, :layout, :display_as, :instructions, :range_min, :range_max, :increment, :field_choices, :required, :visibility, :predefined_value, :priority, :button_label, :button_mode, :button_url, :attachment_type, :attachment_url
  has_many :field_choices
end
