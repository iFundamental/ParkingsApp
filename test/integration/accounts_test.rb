require 'test_helper'

class CarsTest < ActionDispatch::IntegrationTest
  
  setup do
    
  end

  test "user registers a new account" do
    visit register_url
    within('form#new_account') do
      fill_in 'First name', with: 'John'
      fill_in 'Last name', with: 'Smith'
      fill_in 'Email', with: 'email@address.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Register'
    end
    assert has_content?('Account was successfully created.')
    assert_equal current_path, login_path
    within('form#login') do
      fill_in 'Email', with: 'email@address.com'
      fill_in 'Password', with: 'password'
      click_button 'Login'
    end
    assert has_content? 'John Smith'
    
  end
end
