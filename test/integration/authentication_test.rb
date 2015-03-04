require 'test_helper'

class AuthenticationTest < ActionDispatch::IntegrationTest
  setup do
    Capybara.reset
  end
  test 'Test user is not logged in' do
    visit '/'
    assert has_no_content? 'Sally Mclean'
  end
  test 'Existing user logs in' do
    visit new_session_url
    within("//form[@id='login']") do
      fill_in 'Email', with: 'smclean17@gmail.com'
      fill_in 'Password', with: 'TestPassword'
      click_button 'Login'
    end
    assert has_content? 'Sally Mclean'
  end
end


  
