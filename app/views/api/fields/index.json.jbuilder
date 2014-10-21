json.array!(@fields) do |field|
  json.extract! field, :id, :survey_id, :label, :context, :field_size, :layout, :display_as, :instructions, :range_min, :range_max, :increment, :required, :visibility, :predefined_value, :priority, :target_priority, :attachment_type, :attachment_url, :button_label, :button_mode, :button_url, :field_choices
end
