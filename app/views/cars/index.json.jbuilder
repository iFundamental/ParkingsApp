json.array!(@cars) do |car|
  json.extract! car, :id, :model, :registration_number
  json.url car_url(car, format: :json)
end
