json.responses @responses do |response|
  json.extract! response, :id, :survey_id, :clinic_id, :provider_id, :user_agent, :ip_address, :created_at
  json.time response.time
  
  json.answers response.answers.includes(:field) do |answer|
    json.context answer.field.context
    json.label answer.field.label
    json.value answer.value
    json.time answer.time
  end
end
json.response_count @responses.length
