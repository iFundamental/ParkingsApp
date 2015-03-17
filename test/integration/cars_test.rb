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

  test "user adds a new car with image" do
    visit new_car_url
    within('form#new_car') do
      fill_in 'Model', with: 'BMW'
      fill_in 'Registration number', with: 'wwwww-zzzz'
      attach_file 'car_image', File.expand_path('test/fixtures/files/testimage.jpg')
      click_button 'Create Car'
    end
    assert has_content?('Car was successfully created.')
  end

  test "user adds a new car with image to big" do
    visit new_car_url
    within('form#new_car') do
      fill_in 'Model', with: 'BMW'
      fill_in 'Registration number', with: 'wwwww-zzzz'
      attach_file 'car_image', File.expand_path('test/fixtures/files/big_image.jpg')
      click_button 'Create Car'
    end
    assert has_content?('Image should not be greater than 200 KB')
  end

  test "user adds a new car with non image file" do
    visit new_car_url
    within('form#new_car') do
      fill_in 'Model', with: 'BMW'
      fill_in 'Registration number', with: 'wwwww-zzzz'
      attach_file 'car_image', File.expand_path('test/fixtures/files/no_image.txt')
      click_button 'Create Car'
    end
    assert has_content?('must be an image file format of')
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
