require 'test_helper'

class PlaceRentsControllerTest < ActionController::TestCase
  setup do
    @place_rent = place_rents(:one)
  end

  # test "should get index" do
  #   get :index
  #   assert_response :success
  #   assert_not_nil assigns(:place_rents)
  # end

  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end

  # test "should create place_rent" do
  #   assert_difference('PlaceRent.count') do
  #     post :create, parking_place_rent: { ends_at: @place_rent.ends_at, starts_at: @place_rent.starts_at }
  #   end

  #   assert_redirected_to parking_place_rent_path(assigns(:place_rent))
  # end

  # test "should show place_rent" do
  #   get :show, id: @place_rent
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get :edit, id: @place_rent
  #   assert_response :success
  # end

  # test "should update place_rent" do
  #   patch :update, id: @place_rent, place_rent: { ends_at: @place_rent.ends_at, starts_at: @place_rent.starts_at }
  #   assert_redirected_to place_rent_path(assigns(:place_rent))
  # end

  # test "should destroy place_rent" do
  #   assert_difference('PlaceRent.count', -1) do
  #     delete :destroy, id: @place_rent
  #   end

  #   assert_redirected_to place_rents_path
  # end
end
