require 'test_helper'

class ParkingTest < ActiveSupport::TestCase
  test "should have the necessary required validators" do
    p = Parking.new
    assert p.invalid?
    assert_equal [:hour_price, :day_price, :kind], p.errors.keys
  end

  test "should have the necessary numeric validators" do
    p = Parking.new(hour_price: 'sometext', day_price: 'moretext')
    assert p.invalid?
    assert_equal ['is not a number'], p.errors.messages[:hour_price]
    assert_equal ['is not a number'], p.errors.messages[:day_price]
  end

  test "kind should be valid value" do
    p = Parking.new(hour_price: 3.4, day_price: 34, kind: 'invalid value')
    assert p.invalid?

    p.kind = 'outdoor'
    assert p.valid?, 'outdoor should be a valid value.'

    p.kind = 'indoor'
    assert p.valid?, 'indoor should be a valid value.'

    p.kind = 'private'
    assert p.valid?, 'private should be a valid value.'

    p.kind = 'street'
    assert p.valid?, 'street should be a valid value.'
  end

  test  "all open parkings should be closed when parking is destroyed" do
    parking = parkings(:close_rents_test)

    @parking_ends_at_dates = ['2019-04-07 4:30:00', '2200-02-07 4:30:00', '1900-02-07 4:30:00'].collect { |d| DateTime.parse(d) }

    assert @parking_ends_at_dates.include? parking.place_rents[0].ends_at
    assert @parking_ends_at_dates.include? parking.place_rents[1].ends_at
    assert @parking_ends_at_dates.include? parking.place_rents[2].ends_at

    parking.destroy
    car = cars(:close_rent_test_car)

    @cd = Date.current.to_s
    @parking_ends_at_dates_changed = [@cd, '1900-02-07 4:30:00'].collect { |d| DateTime.parse(d).to_date }
    assert @parking_ends_at_dates_changed.include?(car.place_rents[0].ends_at.to_date), 'end date is incorrect: ' + car.place_rents[0].ends_at.to_date.to_s
    assert @parking_ends_at_dates_changed.include?(car.place_rents[1].ends_at.to_date), 'end date is incorrect: ' + car.place_rents[1].ends_at.to_date.to_s
    assert @parking_ends_at_dates_changed.include?(car.place_rents[2].ends_at.to_date), 'end date is incorrect: ' + car.place_rents[2].ends_at.to_date.to_s
  end
end
