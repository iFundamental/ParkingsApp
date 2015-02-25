class Parking < ActiveRecord::Base
  belongs_to :owner, :class_name => 'Person'
  belongs_to :address
  has_many :place_rents
end
