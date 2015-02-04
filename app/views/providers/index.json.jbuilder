json.array!(@providers.includes(:clinics)) do |provider|
  json.extract! provider, :id, :full_name, :name, :surname, :position, :email, :phone, :clinics
  json.created_at provider.created_at.strftime("%B %e, %Y")
  json.photo provider.photo.url(:thumb)

  json.dashboard_url dashboard_url(provider: provider)
  json.edit_url edit_provider_url(provider) if can? :update, provider
end
