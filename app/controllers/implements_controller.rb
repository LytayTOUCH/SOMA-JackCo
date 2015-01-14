class ImplementsController < ApplicationController
  load_and_authorize_resource
  
  def new
    begin
      @implement = Implement.new
      @implement_types = ImplementType.all
    rescue Exception => e
      puts e
    end
  end

  def show
    begin
      @implement = ImplementDecorator.new(Implement.find(params[:id]))
      @maintenances = Maintenance.find_limit_10
    rescue Exception => e
      puts e
    end
  end

  def create
    begin
      @implement = Implement.new(implement_params)

      if @implement.save!
        flash[:notice] = "Implement saved successfully"
        redirect_to :back
      else
        flash[:notice] = "Implement can't save"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  def edit
    begin
      @implement = Implement.find(params[:id])
      @implement_types = ImplementType.all
    rescue Exception => e
      puts e
    end
  end

  def update
    begin
      @implement = Implement.find(params[:id])

      if @implement.update_attributes!(implement_params)
        flash[:notice] = "Implement updated successfully"
        redirect_to implement_path
      else
        flash[:notice] = "Implement category can't update"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  private
  def implement_params
    params.require(:implement).permit(:name, :year, :implement_type_uuid, :value, :own, :note, :photo)
  end
end
