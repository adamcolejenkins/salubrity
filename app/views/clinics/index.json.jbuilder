json.array!(@clinics) do |clinic|
  json.extract! clinic, :id, :title, :guid, :address, :address2, :city, :state, :zip, :phone

  # Total responses for this clinic
  json.total_responses clinic.responses.count

  # Average time for response
  avg = 0.0
  clinic.responses.each_with_index do |response, index|
    avg = ((response.time + (avg * index.to_f)) / (index.to_f + 1)).to_f
  end
  json.average_time to_time_string(avg)
  
  # Group by fields for charts
  json.fields clinic.survey.fields.where.not(context: %w(intro outro provider_dropdown)) do |field|
    json.extract! field, :id, :label, :context

    # Average time for field
    avg = 0.0
    field.answers.each_with_index do |answer, index|
      avg = ((answer.time + (avg * index.to_f)) / (index.to_f + 1)).to_f
    end
    json.average_time to_time_string(avg)

    json.partial! "fields/#{field.context}", field: field, responses: clinic.responses
    json.template "/templates/fields/charts/_#{field.context}.html"

  end

end
