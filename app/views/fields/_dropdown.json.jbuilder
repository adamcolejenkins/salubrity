json.answers field.field_choices do |choice|
  json.extract! choice, :label, :key

  # Number of responses with selected choice
  total = total_answers resource: responses, where: { field: choice.field, value: choice.key }
  json.total total

  # Percentage of responses with selected choice
  json.percent percent(total, responses.count)

  # TODO: Color options
  json.color "TODO: COLOR OPTIONS"
end

# Total choices for this field
json.total_choices field.field_choices.count