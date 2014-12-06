class ImplementsController < ApplicationController
  def new
    @implement = Implement.new
    @implement_types = ImplementType.all
  end

  def show
    @implement = ImplementDecorator.new(Implement.find(params[:id]))
    @maintenances = Maintenance.find_limit_10
  end

  def create
    @implement = Implement.new(implement_params)

    if @implement.save!
      flash[:notice] = "Implement saved successfully"
      redirect_to :back
    else
      flash[:notice] = "Implement can't save"
      redirect_to :back
    end
  end

  def edit
    @implement = Implement.find(params[:id])
    @implement_types = ImplementType.all
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
    rescue Exception => exp
      puts exp
    end
  end

  private
  def implement_params
    params.require(:implement).permit(:name, :year, :implement_type_uuid, :value, :own, :note, :photo)
  end
end
