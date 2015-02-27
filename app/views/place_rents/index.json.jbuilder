json.array!(@place_rents) do |place_rent|
  json.extract! place_rent, :id, :startat, :endat
  json.url place_rent_url(place_rent, format: :json)
end
