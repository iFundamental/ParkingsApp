class CarsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  def index
    @cars = current_person.cars.all
  end

  def show
    @car = Car.find(params[:id])
  end

  def new
    @car = current_person.cars.new
  end

  def edit
    @car = Car.find(params[:id])
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
    @car = Car.find(params[:id])
    if @car.update(car_params)
      redirect_to @car, notice: 'Car was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @car = Car.find(params[:id])
    @car.destroy
    redirect_to cars_url, notice: 'Car was successfully deleted.'
  end

  private

  def car_params
    params.require(:car).permit(:model, :registration_number)
  end

  def record_not_found
    redirect_to cars_url, notice: 'Car not found.'
  end
end
