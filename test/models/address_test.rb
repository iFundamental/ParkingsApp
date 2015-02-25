require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should have the necessary required validators" do
    a = Address.new
    assert a.invalid?
    assert_equal [ :city, :street, :zip_code ], a.errors.keys
  end
  test "Zip code should have specific format 34-483" do
    a = Address.new(city: 'Melbourne', street:'Anthony Street', zip_code: 'xxxxx')
    assert a.invalid?

    @invalid_values =['2333-23423', '53522', '33-3333', '2t-43e']
    @invalid_values.each do |value|
      a.zip_code=value
      assert a.invalid?, value + ' should not be a valid value.'
    end

    a.zip_code='45-245'
    assert a.valid?, '45-245 should be a valid value.'
  end
end
