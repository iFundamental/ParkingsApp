class Parking < ActiveRecord::Base
  belongs_to :owner, :class_name => 'Person'
  belongs_to :address
  has_many :place_rents
  validates :hour_price, :day_price, :presence => true,  :numericality => true
  validate :kind_should_have_valid_value

  def kind_should_have_valid_value
    if !['outdoor', 'indoor', 'private', 'street'].include? kind
      errors.add(:kind, "kind must be a value of outdoor, indoor, private or street")
    end
  end
end
