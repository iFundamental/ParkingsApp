require 'test_helper'

class CarsTest < ActionDispatch::IntegrationTest
  
  setup do
    user_login
  end

  test "user opens cars index" do
    visit cars_url
    assert has_content? 'Cars'
  end

  test "user opens car details" do
    visit cars_url
    click_link('Show', match: :first)
    assert has_content? 'Car Details'
    assert has_content? 'Honda'
  end

  test "user adds a new car" do
    visit new_car_url
    within('form#new_car') do
      fill_in 'Model', with: 'BMW'
      fill_in 'Registration number', with: 'wwwww-zzzz'
      click_button 'Create Car'
    end
    assert has_content?('Car was successfully created.')
  end

  test "user edits a car" do
    visit cars_url
    click_link('Edit', match: :first)
    within('form.edit_car') do
      fill_in 'Model', with: 'Mercedes'
      click_button 'Update Car'
    end
    assert has_content?('Car was successfully updated.')
    assert has_content?('Mercedes')
  end

  test "user removes a car" do
    visit cars_url
    assert_difference "all('tr').count", -1 do
      click_link('Delete', match: :first)
    end
  end
end
