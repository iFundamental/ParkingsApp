require 'test_helper'

class PersonTest < ActiveSupport::TestCase

  test "should have the necessary required validators" do
    person = Person.new
    assert person.invalid?
    assert_equal [:first_name], person.errors.keys
  end
end
