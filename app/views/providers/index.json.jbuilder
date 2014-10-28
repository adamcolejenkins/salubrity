json.array!(@providers) do |provider|
  json.extract! provider, :id, :name, :position, :email, :phone, :photo
  json.url provider_url(provider, format: :json)
end
