class CarsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :find_car, only: [:show, :edit, :update, :destroy]
  before_action :require_login
  
  def index
    @cars = current_person.cars
  end

  def show
  end

  def new
    @car = current_person.cars.new
  end

  def edit
  end

  def create
    @car = current_person.cars.new(car_params)
    if @car.save
      redirect_to @car, notice: 'Car was successfully created.'
    else
      render :new
    end
  end

  def update
    if @car.update(car_params)
      redirect_to @car, notice: 'Car was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @car.destroy
    redirect_to cars_url, notice: 'Car was successfully deleted.'
  end

  private

  def find_car
    @car = current_person.cars.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:model, :registration_number)
  end

  def record_not_found
    redirect_to cars_url, alert: 'Car not found.'
  end
end
