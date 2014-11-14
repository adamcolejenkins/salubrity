# Data
json.data do
  # Labels
  json.labels (field.range_min.to_i..field.range_max.to_i).to_a.map(&:to_s)

  # Datasets
  json.datasets do
    json.array! [field] do
      json.fillColor "#dfe2e7"
      
      # Range data
      json.data do
        i = field.range_min.to_i
        until i > field.range_max.to_i
          total = total_answers resource: resource.responses, where: { field: field, value: i.to_s }
          json.set! i, total

          i += field.increment.to_i
        end
      end
    end
  end
end



# # Scale options
# json.scale do 
#   json.min field.range_min.to_i
#   json.max field.range_max.to_i
#   json.increment field.increment.to_i
#   json.median field.median.to_i
# end

# # Range answers


# # Below Median percent
# below_median_range = (field.range_min.to_i..(field.median.to_i - 1)).to_a.map(&:to_s)
# below_median = total_answers resource: responses, where: { field: field, value: below_median_range }
# json.percent_below_median percent(below_median, responses.count)
# json.below_median_count below_median

# # Above Median percent
# above_median_range = (field.median.to_i..field.range_max.to_i).to_a.map(&:to_s)
# above_median = total_answers resource: responses, where: { field: field, value: above_median_range }
# json.percent_above_median percent(above_median, responses.count)
# json.above_median_count above_median