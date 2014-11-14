json.array! [field] do
  json.name "Responses"
  # Data
  json.data do
    i = field.range_min.to_i
    until i > field.range_max.to_i
      total = total_answers resource: resource.responses, where: { field: field, value: i.to_s }
      json.set! "Rating of " + i.to_s, total

      i += field.increment.to_i
    end
  end
end