json.array!(@devices) do |device|
  json.extract! device, :id, :team_id, :clinic_id, :udid, :imei, :os, :os_verion, :version, :product, :color, :active
  json.url device_url(device, format: :json)
end
