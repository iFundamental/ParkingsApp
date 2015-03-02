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
end
