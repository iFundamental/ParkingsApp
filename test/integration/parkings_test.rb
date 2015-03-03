require 'test_helper'

class ParkingsTest < ActionDispatch::IntegrationTest
  test "user opens parkings index" do
    visit parkings_url
    assert has_content? 'Parkings'
  end

  test "user opens parking details" do
    visit parkings_url
    click_link('Show', match: :first)
    assert has_content? 'View Parking Details'
    assert has_content? 'indoor'
  end

  test "user adds a new parking" do
    visit new_parking_url
    within("//form[@id='new_parking']") do
      fill_in 'Kind', with: 'indoor'
      fill_in 'Places', with: 9
      fill_in 'Hour price', with: 4.5
      fill_in 'Day price', with: 5.5
      fill_in 'City', with: 'Townsville'
      fill_in 'Street', with: 'Long Street'
      fill_in 'Zip code', with: '45-399'
      click_button 'Create Parking'
    end
    assert has_content?('Parking was successfully created.')
  end

  test "user edits a parking" do
    visit parkings_url
    click_link('Edit', match: :first)
    within("//form[@class='edit_parking']") do
      fill_in 'City', with: 'Perth'
      click_button 'Update Parking'
    end
    assert has_content?('Parking was successfully updated.')
    assert has_content?('Perth')
  end

  test "user removes a parking" do
    visit parkings_url
    finalcount = all('tr').count - 1
    click_link('Delete', match: :first)
    assert_equal finalcount, all('tr').count
  end

  test "user searches parkings day price " do
    visit parkings_url
    within("//form[@id='parking_search']") do
      #fill_in 'Hour price from', with: 1
      #fill_in 'Hour price to', with: 3
      fill_in 'Day price from', with: 10
      fill_in 'Day price to', with: 10
      fill_in 'City', with: ''
      check 'Show private'
      check 'Show public'
      click_button 'Search Parkings'
    end
    assert has_content?('Berlin')
  end

  test "user searches parkings hour price range" do
    visit parkings_url
    within("//form[@id='parking_search']") do
      fill_in 'Hour price from', with: 0
      fill_in 'Hour price to', with: 1
      #fill_in 'Day price from', with: 1
      #fill_in 'Day price to', with: 3
      fill_in 'City', with: ''
      check 'Show private'
      check 'Show public'
      click_button 'Search Parkings'
    end
    assert has_content?('Berlin')
  end

  test "user searches parkings city search" do
    visit parkings_url
    within("//form[@id='parking_search']") do
      fill_in 'City', with: 'Ber'
      check 'Show private'
      check 'Show public'
      click_button 'Search Parkings'
    end
    assert has_content?('Berlin')
    assert has_no_content?('Perth')
  end
end
