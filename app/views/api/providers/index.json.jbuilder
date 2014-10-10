json.array!(@providers) do |provider|
  json.extract! provider, :id, :clinic_id, :position, :email, :phone, :photo, :created_at, :updated_at
end
