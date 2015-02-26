require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  test "should have the necessary required validators" do
    a = Address.new
    assert a.invalid?
    assert_equal [ :city, :street, :zip_code ], a.errors.keys
  end

  test "Zip code should have specific format 34-483" do
    a = Address.new(city: 'Melbourne', street:'Anthony Street', zip_code: 'xxxxx')
    
    a.zip_code='2333-23423'
    assert a.invalid?, '2333-23423 should not be a valid value.'

    a.zip_code='53522'
    assert a.invalid?, '53522 should not be a valid value.'

    a.zip_code='33-3333'
    assert a.invalid?, '33-3333 should not be a valid value.'

    a.zip_code='2t-43e'
    assert a.invalid?, '2t-43e should not be a valid value.'

    a.zip_code='45-245'
    assert a.valid?, '45-245 should be a valid value.'
  end
end
