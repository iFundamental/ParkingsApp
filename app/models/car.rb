class Car < ActiveRecord::Base
  belongs_to :owner, class_name: :'Person'
  has_many :place_rents
  validates :model, :registration_number, :owner, presence: :true
end
