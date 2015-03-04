require 'test_helper'

class AccountTest < ActiveSupport::TestCase

  test "should validate correct account password return account object" do 
    assert_equal 'smclean17@gmail.com',  Account.authenticate('smclean17@gmail.com', 'testpassword').email
    
  end

  test "should not validate incorrect account password - return nil" do 
    assert_equal false,  Account.authenticate('smclean17@gmail.com', 'wrongpassword')
    
  end
end
