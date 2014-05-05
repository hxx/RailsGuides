json.array!(@clients) do |client|
  json.extract! client, :id, :name, :phone, :address
  json.url client_url(client, format: :json)
end
