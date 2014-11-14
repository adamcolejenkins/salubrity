json.array!(@installs) do |install|
  json.extract! install, :id
  json.url install_url(install, format: :json)
end
