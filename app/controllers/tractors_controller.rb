class TractorsController < ApplicationController
  def new
    @tractor = Tractor.new
  end

  def create
    @tractor = Tractor.new(tractor_params)

    if @tractor.save
      flash[:notice] = "Tractor saved successfully"
      redirect_to machineries_path
    else
      flash[:notice] = "Tractor can't save"
    end
  end

  def show
    @tractor = TractorDecorator.new(Tractor.find(params[:id]))
  end

  def edit
    @tractor = Tractor.find(params[:id])
  end

  def update
    @tractor = Tractor.find(params[:id])

    if @tractor.update_attributes!(tractor_params)
      flash[:notice] = "Tractor updated successfully"
      redirect_to tractor_path
    else
      flash[:notice] = "Listing category can't update"
    end
  end

  private
  def tractor_params
    params.require(:tractor).permit(:name, :horse_power, :fuel_capacity, :make, :model, :year, :value, :own, :note, :photo)
  end
end
