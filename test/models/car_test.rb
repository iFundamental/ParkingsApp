require 'test_helper'

class CarTest < ActiveSupport::TestCase

  test "should have the necessary required validators" do
    car = Car.new
    assert car.invalid?
    assert_equal [:model, :registration_number, :owner], car.errors.keys
  end
end
