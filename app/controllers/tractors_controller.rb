class TractorsController < ApplicationController
  load_and_authorize_resource
  
  def new
    begin
      @tractor = Tractor.new
    rescue Exception => e
      puts e
    end
  end

  def show
    begin
      @tractor = TractorDecorator.new(Tractor.find(params[:id]))
      @maintenances = Maintenance.find_limit_10
    rescue Exception => e
      puts e
    end
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
    begin
      @tractor = Tractor.find(params[:id])
    rescue Exception => e
      puts e
    end
  end

  def update
    begin
      @tractor = Tractor.find(params[:id])

      if @tractor.update_attributes!(tractor_params)
        flash[:notice] = "Tractor updated successfully"
        redirect_to tractor_path
      else
        flash[:notice] = "Tractor can't update"
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
