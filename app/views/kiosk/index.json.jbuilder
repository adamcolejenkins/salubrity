json.array!(@kiosks) do |kiosk|
  json.extract! kiosk, :id
  json.url kiosk_url(kiosk, format: :json)
end
