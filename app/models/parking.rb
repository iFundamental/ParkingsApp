class Parking < ActiveRecord::Base
  belongs_to :owner, class_name: :'Person'
  belongs_to :address, dependent: :destroy
  has_many :place_rents
  before_destroy :close_all_parkings

  validates :hour_price, :day_price, presence: true,  numericality: true
  validates :kind, inclusion: { in: %w(outdoor indoor private street), message: "%{value} is not a valid kind" }

  accepts_nested_attributes_for :address, allow_destroy: true



  private

  def close_all_parkings 
    place_rents.each do |place_rent| 
      place_rent.close_parking 
      place_rent.save
    end

  end
end
