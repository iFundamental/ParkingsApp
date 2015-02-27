json.array!(@place_rents) do |place_rent|
  json.extract! place_rent, :id, :starts_at, :ends_at
  json.url place_rent_url(place_rent, format: :json)
end
