class PlaceRent < ActiveRecord::Base
  belongs_to :car
  belongs_to :parking
  validates :starts_at, :ends_at, :parking, :car, presence: true
  before_save :set_price

  def close_parking
    self.ends_at = Time.now if ends_at >= Time.now
  end

  private

  def calculate_price

    start_d = starts_at.beginning_of_hour
    end_d = ends_at
    day_p = (parking.day_price).round(2)
    hour_p = (parking.hour_price).round(2)

    unless end_d == end_d.beginning_of_hour
      end_d = (end_d + 1.hour).at_beginning_of_hour
    end

    if end_d.to_date == start_d.to_date
      (((end_d - start_d) / 1.hour).round) * parking.hour_price
    else
      @start_day_hours = (((start_d.at_end_of_day - start_d) / 1.hour).round)
      @days = (end_d.at_beginning_of_day - (start_d + 1.days).at_beginning_of_day).to_i / 1.day
      @end_day_hours = (((end_d - end_d.at_beginning_of_day) / 1.hour).round)
      if @start_day_hours == 24
        @days += 1
        @start_day_hours = 0
      end
      if @end_day_hours == 24
        @days += 1
        @end_day_hours = 0
      end
      ((@days * day_p) + (@start_day_hours + @end_day_hours) * hour_p).round(2)
    end
  end

  def set_price
    self.price = calculate_price
  end
end
