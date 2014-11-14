# json.answers field.field_choices do |choice|
#   json.extract! choice, :label, :key

#   # Number of responses with selected choice
#   total = total_answers resource: responses, where: { field: choice.field, value: choice.key }
#   json.data total

#   # Percentage of responses with selected choice
#   json.percent percent(total, responses.count)

#   # TODO: Color options
#   json.color
# end

# # Total choices for this field
# json.total_choices field.field_choices.count

# Data for the charts
json.data field.field_choices do |choice|
  # Return the label
  json.extract! choice, :label
  # Return the value
  json.value total_answers(resource: responses, where: { field: choice.field, value: choice.id })
  # Return the color
  json.color choice.color if choice.attribute_present?(:color)
  # Return the highlight color
  json.highlight lighten_color(choice.color, 0.1) if choice.attribute_present?(:color)
end