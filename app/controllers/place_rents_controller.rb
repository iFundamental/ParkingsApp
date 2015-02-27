class PlaceRentsController < ApplicationController
  before_action :set_place_rent, only: [:show, :edit, :update, :destroy]

  # GET /place_rents
  # GET /place_rents.json
  def index
    @place_rents = PlaceRent.all
  end

  # GET /place_rents/1
  # GET /place_rents/1.json
  def show
  end

  # GET /place_rents/new
  def new
    @place_rent = PlaceRent.new
    # @place_rent.parking = Parking.find(params[:parking_id])
    @cars = current_person.cars.all
  end

  # GET /place_rents/1/edit
  def edit
  end

  # POST parkings/:id/place_rents
  # POST parkings/:id/place_rents.json
  def create
    @place_rent = PlaceRent.new(place_rent_params)
    @place_rent.car = Car.find(place_rent_params[:car_id])
    @place_rent.parking = Parking.find(params[:parking_id])
    if @place_rent.save
      redirect_to @place_rent, notice: 'Place rent was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT parkings/:id/place_rents/1
  # PATCH/PUT parkings/:id/place_rents/1.json
  def update
    if @place_rent.update(place_rent_params)
      redirect_to @place_rent, notice: 'Place rent was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE parkings/:id/place_rents/1
  # DELETE parkings/:id/place_rents/1.json
  def destroy
    @place_rent.destroy
    redirect_to place_rents_url, notice: 'Place rent was successfully destroyed.'
    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_place_rent
    @place_rent = PlaceRent.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def place_rent_params
    params.require(:place_rent).permit(:car_id, :starts_at, :ends_at)
  end
end
