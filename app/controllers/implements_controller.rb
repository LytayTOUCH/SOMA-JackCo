class ImplementsController < ApplicationController
  def new
    @implement = Implement.new
  end

  def show
    @implement = ImplementDecorator.new(Implement.find(params[:id]))
  end

  def create
    @implement = Implement.new(implement_params)

    if @implement.save!
      flash[:notice] = "Implement saved successfully"
      redirect_to machineries_path
    else
      flash[:notice] = "Implement can't save"
      redirect_to :back
    end
  end

  def edit
    @implement = Implement.find(params[:id])
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
