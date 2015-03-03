class CarsController < ApplicationController

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

  def car_params
    params.require(:car).permit(:model, :registration_number)
  end
end
