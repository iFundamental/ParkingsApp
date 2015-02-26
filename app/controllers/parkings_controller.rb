class ParkingsController < ApplicationController
  def index
    @parkings = Parking.all
  end

  def show
    @parking = Parking.find(params[:id])
  end

  def new
    @parking = Parking.new
  end

  def create
    @parking = Parking.new(parking_params)
    if @parking.save
      redirect_to @parking
    else
      render 'new'
    end
  end

  private

  def parking_params
    params.require(:parking).permit(:kind, :places, :hour_price, :day_price, :text)
  end

  def edit
    @parking = Parking.find(params[:id])
  end

  def update
    @parking = Parking.find(params[:id])
    @parking.update(parking_params)
    if @parking.save
      redirect_to @parking
    else
      render 'new'
    end
  end
end
