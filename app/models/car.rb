class Car < ActiveRecord::Base
  belongs_to :owner, class_name: :'Person'
  has_many :place_rents, dependent: :destroy
  validates :model, :registration_number, :owner, presence: true

  def car_model_registration
    model + ' - ' + registration_number
  end
end
