require 'test_helper'

class CarTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
 test "should have the necessary required validators" do
  post = Car.new
  assert_not post.valid?
  assert_equal [:model, :registration_number, :owner], post.errors.keys
end
end
