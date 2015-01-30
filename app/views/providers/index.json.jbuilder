json.array!(@providers.includes(:clinics)) do |provider|
  json.extract! provider, :id, :full_name, :position, :email, :phone
  json.created_at provider.created_at.strftime("%B %e, %Y")
  json.photo provider.photo.url(:thumb)
  
  json.clinics provider.clinics do |clinic|
    json.title clinic.title
  end

  json.dashboard_url dashboard_url(provider: provider)
  json.edit_url edit_provider_url(provider) if can? :update, provider
end
