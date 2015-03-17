require 'test_helper'

class AuthenticationTest < ActionDispatch::IntegrationTest
  setup do
    OmniAuth.config.mock_auth[:facebook] = nil
  end

  test 'Test user is not logged in' do
    visit '/'
    assert has_no_content? 'Sally Mclean'
  end
  test 'Existing user logs in' do
    visit login_url
    within('form#login') do
      fill_in 'Email', with: 'smclean17@gmail.com'
      fill_in 'Password', with: 'testpassword'
      click_button 'Login'
    end
    assert has_content? 'Sally Mclean'
    assert_equal current_path, root_path
  end

  test 'Existing user logs in from starting not logged in at cars' do
    visit cars_url
    within('form#login') do
      fill_in 'Email', with: 'smclean17@gmail.com'
      fill_in 'Password', with: 'testpassword'
      click_button 'Login'
    end
    assert has_content? 'Sally Mclean'
    assert_equal current_path, cars_path
  end

  test 'User Logs out' do
    user_login
    assert has_content? 'Sally Mclean'
    within('.navbar-header') do
      click_link 'Log out'
    end
    assert has_no_content? 'Sally Mclean'
  end

  test 'User Logs in with facebook' do
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:facebook, uid: '12345')
    visit login_url
    click_link 'Login with Facebook'
    assert has_content? 'Sally Mclean'
    assert_equal current_path, root_path
  end
end
