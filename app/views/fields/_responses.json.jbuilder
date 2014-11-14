# Data
json.data do

  labels = []
  data = []

  json.test resource.responses.group_by(&:created_at).each do |date, response|
    
  end


  # Labels
  json.labels Date.today.downto(Date.today - 1.week).to_a.reverse.map { |d| d.strftime("%A, %B %e") }

  # Datasets
  json.datasets do
    json.array! [resource] do
      json.fillColor "#dfe2e7"
      
      # Range data
      json.data resource.responses.group('date(created_at)').count
    end
  end
end