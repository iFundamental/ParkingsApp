class PlaceRent < ActiveRecord::Base
  belongs_to :car
  belongs_to :parking
  validates :starts_at, :ends_at, :parking, :car, presence: true

  
  

  def calculate_price
    start_d = starts_at.end_of_minute
    end_d = ends_at.end_of_minute
    day_p = (parking.day_price).round(2)
    hour_p = (parking.hour_price).round(2)
    
    if end_d.to_date == start_d.to_date
      (((end_d - start_d) / 1.hour).round) * parkng.hour_price
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
end
