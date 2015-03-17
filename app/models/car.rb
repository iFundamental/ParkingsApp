class Car < ActiveRecord::Base
  belongs_to :owner, class_name: :'Person'
  has_many :place_rents, dependent: :destroy
  validates :model, :registration_number, :owner, presence: true
  dragonfly_accessor :image
  validates_size_of :image, maximum: 200.kilobytes, message:'should not be greater than 200 KB', if: :image_changed?
  validates_property :format, of: :image, in: [:jpeg, :jpg, :png, :bmp], case_sensitive: false, message: 'must be an image file format of .jpeg, .jpg, .png, .bmp', if: :image_changed?

  def car_model_registration
    model + ' - ' + registration_number
  end

  def to_param
    "#{id}-#{model}"
  end
end
