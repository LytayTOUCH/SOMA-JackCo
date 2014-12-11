class WarehouseTypesController < ApplicationController
  load_and_authorize_resource
  
  def index
    @warehouse_types = WarehouseType.all
  end

  def new
    @warehouse_type = WarehouseType.new
  end

  def create   
    @warehouse_type = WarehouseType.new(warehouse_type_params)
    if @warehouse_type.save!
      flash[:notice] = "Warehouse type saved successfully"
      redirect_to warehouse_types_path
    else
      flash[:notice] = "Warehouse type can't save"
      redirect_to :back
    end
  end

  def show
    @warehouse_type = WarehouseType.find(params[:id])
  end

  def edit
    @warehouse_type = WarehouseType.find(params[:id])
  end

  def update
    @warehouse_type = WarehouseType.find(params[:id])
    if @warehouse_type.update_attributes!(warehouse_type_params)
      flash[:notice] = "WarehouseType updated"
      redirect_to warehouse_types_path
    else
      redirect_to :back
    end
  end

  private
  def warehouse_type_params
    params.require(:warehouse_type).permit(:name, :note, :active)
  end
end
