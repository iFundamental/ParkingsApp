require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should have the necessary required validators" do
  post = Person.new
  assert_not post.valid?
  assert_equal [:first_name], post.errors.keys
end
end
