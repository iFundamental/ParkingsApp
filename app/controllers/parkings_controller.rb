class ParkingsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :find_parking, only: [:show, :edit, :update, :destroy]

  def index
    @search_params = search_params
    if params.key?('commit')
      @parkings = Parking.parking_search(search_params).page(params[:page])
    else
      @parkings = Parking.all.page(params[:page])
    end
  end

  def show
  end

  def new
    @parking = Parking.new
    @parking.build_address
  end

  def create
    @parking = Parking.new(parking_params)
    if @parking.save
      redirect_to @parking, notice: t('parking_create_success')
    else
      render :new
    end
  end

  def edit
  
  end

  def update
    if @parking.update(parking_params)
      redirect_to @parking, notice: t('parking_update_success')
    else
      render :edit
    end
  end
  
  def destroy
    @parking.destroy
    redirect_to action: :index, notice: t('parking_success_delete')
  end

  private

  def find_parking
    @parking = Parking.find(params[:id])
  end

  def parking_params
    params.require(:parking).permit(:kind, :places, :hour_price, :day_price, address_attributes: [:city, :zip_code, :street])
  end

  def search_params
    params.permit(:hour_price_from, :hour_price_to, :day_price_from, :day_price_to, :city_name, :show_private, :show_public)
  end

  def record_not_found
    redirect_to parkings_url, alert: t('parking_not_found')
  end
end
