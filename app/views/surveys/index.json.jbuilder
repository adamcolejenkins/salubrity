json.array!(@surveys) do |survey|
  json.extract! survey, :id, :title, :description, :guid, :status

  # Total responses for this survey
  json.total_responses survey.responses.count

  # Average time for response
  avg = 0.0
  survey.responses.each_with_index do |response, index|
    avg = ((response.time + (avg * index.to_f)) / (index.to_f + 1)).to_f
  end
  json.average_time to_time_string(avg)
  
  # Group by fields for charts
  json.fields survey.fields.where.not(context: %w(intro outro provider_dropdown)) do |field|
    json.extract! field, :id, :label, :context

    # Average time for field
    avg = 0.0
    field.answers.each_with_index do |answer, index|
      avg = ((answer.time + (avg * index.to_f)) / (index.to_f + 1)).to_f
    end
    json.average_time to_time_string(avg)

    json.partial! "fields/#{field.context}", field: field, responses: survey.responses
    json.template "/templates/fields/charts/_#{field.context}.html"

  end

end
