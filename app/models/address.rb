class Address < ActiveRecord::Base
  has_one :parking
  validates :city, :street, :zip_code, presence: :true
  validates :zip_code,  format: { :with => /\A[0-9]{2}-[0-9]{3}\Z/, :message =>  'Zip code should have specific format (e.g. 34-483)' }
end
