class TractorsController < ApplicationController
  load_and_authorize_resource
  
  def new
    @tractor = Tractor.new
  end

  def show
    @tractor = TractorDecorator.new(Tractor.find(params[:id]))
    @maintenances = Maintenance.find_limit_10
  end
  
  def create
    begin
      @tractor = Tractor.new(tractor_params)

      if @tractor.save!
        flash[:notice] = "Tractor saved successfully"
        redirect_to :back
      else
        flash[:notice] = "Tractor can't save"
        redirect_to :back
      end
    rescue Exception => exp
      puts exp
    end
  end

  def edit
    @tractor = Tractor.find(params[:id])
  end

  def update
    begin
      @tractor = Tractor.find(params[:id])

      if @tractor.update_attributes!(tractor_params)
        flash[:notice] = "Tractor updated successfully"
        redirect_to tractor_path
      else
        flash[:notice] = "Listing category can't update"
        redirect_to :back
      end
    rescue Exception => exp
      puts exp
    end
  end

  private
  def tractor_params
    params.require(:tractor).permit(:name, :horse_power, :fuel_capacity, :make, :model, :year, :value, :own, :note, :photo)
  end
end
