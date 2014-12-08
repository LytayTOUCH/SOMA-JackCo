class ImplementTypesController < ApplicationController
  def index
    @implement_types = ImplementType.page(params[:page]).per(5)
  end

  def new
    @implement_type = ImplementType.new
  end

  def create
    begin
      @implement_type = ImplementType.new(implement_type_params)

      if @implement_type.save!
        flash[:notice] = "ImplementType saved successfully"
        redirect_to :back
      else
        flash[:notice] = "ImplementType can't save"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  def edit
    @implement_type = ImplementType.find(params[:id])
  end

  def update
    begin
      @implement_type = ImplementType.find(params[:id])

      if @implement_type.update_attributes!(implement_type_params)
        flash[:notice] = "ImplementType updated successfully"
        redirect_to implement_types_path
      else
        flash[:notice] = "ImplementType category can't update"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  private
  def implement_type_params
    params.require(:implement_type).permit(:name, :note)
  end
end
