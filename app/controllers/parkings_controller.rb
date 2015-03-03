class ParkingsController < ApplicationController
  def index
    @parkings = Parking.all
    # @test = params
    # @test2 = params.has_key?("search")
    @search_params = search_params
  end

  def show
    @parking = Parking.find(params[:id])
  end

  def new
    @parking = Parking.new
    @parking.build_address
  end

  def create
    @parking = Parking.new(parking_params)
    if @parking.save
      redirect_to @parking, notice: 'Parking was successfully created.'
    else
      render :new
    end
  end

  def edit
    @parking = Parking.find(params[:id])
  end

  def update
    @parking = Parking.find(params[:id])
    if @parking.update(parking_params)
      redirect_to @parking, notice: 'Parking was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    Parking.find(params[:id]).destroy
    redirect_to action: :index, notice: 'Parking was successfully deleted.'
  end

  private

  def parking_params
    params.require(:parking).permit(:kind, :places, :hour_price, :day_price, address_attributes: [:city, :zip_code, :street])
  end

  def search_params
    if params.has_key?('search')
       params[:search].permit(:hour_price, :day_price, :city_name, :show_private, :show_public)
    else
      { hour_price: '', day_price: '', city_name: 'test', show_private: 0, show_public: 0 }
    end

  end
end
