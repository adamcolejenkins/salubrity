json.array!(@providers) do |provider|
  json.extract! provider, :id, :clinic_id, :full_name, :position, :email, :phone
  json.photo provider.photo.url(:thumb)
  
  json.clinics [provider.clinic] do |clinic|
    json.title clinic.title
  end

  json.dashboard_url dashboard_url(provider: provider)
  json.edit_url edit_provider_url(provider) if can? :update, provider
end
