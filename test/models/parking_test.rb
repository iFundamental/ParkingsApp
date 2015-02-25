require 'test_helper'

class ParkingTest < ActiveSupport::TestCase
 test "should have the necessary required validators" do
    p = Parking.new
    assert_not p.valid?
    assert_equal [:hour_price, :day_price, :kind], p.errors.keys
  end
 test "should have the necessary numeric validators" do
    p = Parking.new(hour_price: 'sometext', day_price: 'moretext')
    assert_not p.valid?
    assert_equal ["is not a number"], p.errors.messages[:hour_price]
    assert_equal ["is not a number"], p.errors.messages[:day_price]
  end
 test "kind should be valid value" do
    p = Parking.new(hour_price: 3.4, day_price: 34, kind: 'invalid value')
    assert_not p.valid?
    @valid_values =['outdoor', 'indor', 'private', 'street']
    @valid_values.each do |value|
    	p.kind=value
    	assert p.valid?, value + ' should be a valid value.'
    end
  end
end
