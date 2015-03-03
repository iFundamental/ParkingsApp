class Parking < ActiveRecord::Base
  belongs_to :owner, class_name: :'Person'
  belongs_to :address, dependent: :destroy
  has_many :place_rents
  before_destroy :close_all_parkings

  validates :hour_price, :day_price, presence: true,  numericality: true
  validates :kind, inclusion: { in: %w(outdoor indoor private street), message: "%{value} is not a valid kind" }

  accepts_nested_attributes_for :address, allow_destroy: true

  scope :city_starts_with,   -> (city_name) {  joins(:address).where('addresses.city like ?', "#{city_name}%") }
  scope :day_price_between,  -> (start_price, end_price) { where('parkings.day_price between ? and ?', start_price, end_price) }
  scope :hour_price_between, -> (start_price, end_price) { where('parkings.hour_price between ? and ?', start_price, end_price) }
  scope :private_parkings,   -> { where(kind: :private) }
  scope :public_parkings,    -> { where("parkings.kind != 'private'") }


  def self.parking_search(params)
    @parkings = Parking.where(nil)
    @parkings = @parkings.city_starts_with(params[:city_name]) if params[:city_name].present?
    @parkings = @parkings.public_parkings if params[:show_public].present? && params[:show_public] == 1
    @parkings = @parkings.private_parkings if params[:show_private].present? && params[:show_private] == 1
    @parkings = @parkings.day_price_between(params[:day_price_from], params[:day_price_to]) if params[:day_price_from].present? && params[:day_price_to].present?
    @parkings = @parkings.hour_price_between(params[:hour_price_from], params[:hour_price_to]) if params[:hour_price_from].present? && params[:hour_price_to].present?
    @parkings
  end

  private

  def close_all_parkings 
    place_rents.each do |place_rent| 
      place_rent.close_parking 
      place_rent.save
    end

  end
end
