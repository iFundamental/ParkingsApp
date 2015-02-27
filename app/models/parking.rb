class Parking < ActiveRecord::Base
  belongs_to :owner, class_name: :'Person'
  belongs_to :address, dependent: :destroy
  has_many :place_rents

  validates :hour_price, :day_price, presence: :true,  numericality: :true
  validates :kind, inclusion: { in: %w(outdoor indoor private street), message: "%{value} is not a valid kind" }

  accepts_nested_attributes_for :address, allow_destroy: :true
end
