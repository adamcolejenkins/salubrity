json.comments responses do |response|
  response.answers.where({ field: field }).each do |answer|
    json.comment strip_tags(answer.value).strip
  end
end