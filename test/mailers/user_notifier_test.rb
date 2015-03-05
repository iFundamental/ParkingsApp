require 'test_helper'

class UserNotifierTest < ActionMailer::TestCase

  test "send_signup_email" do
    # Send the email, then test that it got queued
    account =  accounts(:one)
    email = UserNotifier.send_signup_email(account).deliver_now

    
    assert_not ActionMailer::Base.deliveries.empty?
 
    # Test the body of the sent email contains what we expect it to
    assert_equal ['hello@bookparking.dev'], email.from
    assert_equal ['smclean17@gmail.com'], email.to
    assert_equal 'Welcome to Bookparking', email.subject
   # assert_equal read_fixture('send_signup_email').join, email.body.to_s
  end
end
