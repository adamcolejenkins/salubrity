json.answers responses do |response|
  response.answers.where({ field: field }).each do |answer|
    json.response_id response.id
    json.number answer.value.to_i
  end
end