require 'test_helper'

class AuthenticationTest < ActionDispatch::IntegrationTest


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
    assert current_path == root_path
  end

  test 'Existing user logs in from starting not logged in at cars' do
    visit cars_url
    within('form#login') do
      fill_in 'Email', with: 'smclean17@gmail.com'
      fill_in 'Password', with: 'testpassword'
      click_button 'Login'
    end
    assert has_content? 'Sally Mclean'
    assert current_path == cars_path
  end
end

  
