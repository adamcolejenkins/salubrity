json.array!(@providers) do |provider|
  json.extract! provider, :id, :name, :position, :email, :phone
  json.photo provider.photo.url(:thumb)

  # Total responses for this provider
  json.total_responses provider.responses.count

  # TODO: Average time for response
  json.average_time "00:00"
  
  # Group by fields for charts
  json.fields provider.clinic.survey.fields.where.not(context: %w(intro outro provider_dropdown)) do |field|
    json.extract! field, :id, :label, :context

    # TODO: Average time for field
    json.average_time "00:00"

    json.partial! "fields/#{field.context}", field: field, responses: provider.responses

  end

  time = 0
  provider.responses.each do |response|
    time += time_diff(response.started_at, response.ended_at)
  end

  logger.debug(time)
  time = time / provider.responses.count unless provider.responses.count == 0

  logger.debug(time)
end
