json.array!(@clinics) do |clinic|
  json.extract! clinic, :id, :title, :guid, :address, :address2, :city, :state, :zip, :phone

  # Total responses for this clinic
  json.total_responses clinic.responses.count

  json.dashboard_url dashboard_url(clinic: clinic)
  json.edit_url edit_clinic_url(clinic) if can? :update, clinic
end
