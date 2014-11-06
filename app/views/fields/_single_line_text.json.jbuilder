json.answers responses do |response|
  response.answers.where({ field: field }).each do |answer|
    json.response_id response.id
    json.text strip_tags(answer.value).strip
  end
end