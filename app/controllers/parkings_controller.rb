class ParkingsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @search_params = search_params
    if @search_params.key?(:filter)
      @parkings = Parking.all.page(params[:page])
    else
      @parkings = Parking.parking_search(@search_params).page(params[:page])
    end
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
      redirect_to @parking, notice: t('parking_create_success')
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
      redirect_to @parking, notice: t('parking_update_success')
    else
      render :edit
    end
  end

  def destroy
    Parking.find(params[:id]).destroy
    redirect_to action: :index, notice: t('parking_success_delete')
  end

  private

  def parking_params
    params.require(:parking).permit(:kind, :places, :hour_price, :day_price, address_attributes: [:city, :zip_code, :street])
  end

  def search_params
    if params.key?('search')
      params[:search].permit(:hour_price_from, :hour_price_to, :day_price_from, :day_price_to, :city_name, :show_private, :show_public)
    else
      { hour_price_from: '', hour_price_to: '', day_price_from: '', day_price_to: '', city_name: '', show_private: 1, show_public: 1, filter: false }
    end

  end

  def record_not_found
    redirect_to parkings_url, alert: t('parking_not_found')
  end
end
