json.array!(@clinics) do |clinic|
  json.extract! clinic, :id, :title, :survey_id, :guid, :address, :address2, :city, :state, :zip, :phone
end
