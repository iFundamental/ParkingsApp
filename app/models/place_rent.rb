class PlaceRent < ActiveRecord::Base
  belongs_to :cars
  belongs_to :parkings
  validates :starts_at, :ends_at, :parkings, :cars, :presence => true
end
