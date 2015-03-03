class PlaceRentsController < ApplicationController

  def index
    @place_rents = PlaceRent.all
  end

  def show
     @place_rent = PlaceRent.find(params[:id])
  end

  def new
    @place_rent = PlaceRent.new
    @cars = current_person.cars
  end

  def edit
     @place_rent = PlaceRent.find(params[:id])
  end

  def create
    @place_rent = PlaceRent.new(place_rent_params)
    @place_rent.car = Car.find(place_rent_params[:car_id])
    @place_rent.parking = Parking.find(params[:parking_id])
    if @place_rent.save
      redirect_to @place_rent, notice: 'You have successfully rented the place.'
    else
      render :new
    end
  end

  def update
    if @place_rent.update(place_rent_params)
      redirect_to @place_rent, notice: 'Place rent was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @place_rent.destroy
    redirect_to place_rents_url, notice: 'Place rent was successfully deleted.'
  end

  private

  def place_rent_params
    params.require(:place_rent).permit(:car_id, :starts_at, :ends_at)
  end
end

