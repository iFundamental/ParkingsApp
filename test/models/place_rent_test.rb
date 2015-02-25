require 'test_helper'

class PlaceRentTest < ActiveSupport::TestCase

  test "should have the necessary required validators" do
    place_rent = PlaceRent.new
    assert place_rent.invalid?
    assert_equal [:starts_at, :ends_at, :parkings, :cars], place_rent.errors.keys
  end
end
