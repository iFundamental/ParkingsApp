require 'test_helper'

class PlaceRentTest < ActiveSupport::TestCase

  test "should have the necessary required validators" do
    place_rent = PlaceRent.new
    assert place_rent.invalid?
    assert_equal [:starts_at, :ends_at, :parking, :car], place_rent.errors.keys
  end

  test "calculate_price_full_days" do
    # "price = day_price * days + hour_price * hours"
    place_rent = place_rents(:calc_test_1)
    # 7 * 7.5 day price days
    assert_not_nil place_rent.parking
    assert_equal(BigDecimal('52.5'), place_rent.send(:calculate_price) )
  end

  test "calculate price extra hours on last day" do
    # seven days and 3 hours  7*7.5 + 3 * 1.5
    place_rent = place_rents(:calc_test_2)

    assert_equal(BigDecimal('57'),  place_rent.send(:calculate_price) )
  end

  test "calculate price extra hours on first day" do
    # six days and 2 hours  6*7.5 + 2 * 1.5
    place_rent = place_rents(:calc_test_3)
    assert_equal(BigDecimal('48'), place_rent.send(:calculate_price) )
  end

  test "calculate price extra hours on first and last day with miniutes" do
    # five days and 2  hours on first day, 5 hours on last day  5*7.5 = 37.5  2 * 1.5 = 3  5 * 1.5  = 7.5
    place_rent = place_rents(:calc_test_4)
    assert_equal(BigDecimal('48'), place_rent.send(:calculate_price))
  end

  test "set price on save" do
    # five days and 2  hours on first day, 5 hours on last day  5*7.5 = 37.5  2 * 1.5 = 3  5 * 1.5  = 7.5
    place_rent = place_rents(:calc_test_4)
    place_rent.save
    assert_equal(BigDecimal('48'), place_rent.price)
  end
end
