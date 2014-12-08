class WarehousesController < ApplicationController
  # load_and_authorize_resource

  def index
    @warehouses = Warehouse.all
  end

  def new
    @warehouse = Warehouse.new
    @warehouse_types = WarehouseType.all
  end

  def create
    puts "=========================================="
    @warehouse = Warehouse.new(warehouse_params)
    puts "=========================================="
    if @warehouse.save!
      flash[:notice] = "Warehouse saved successfully"
      redirect_to warehouses_path
    else
      flash[:notice] = "Warehouse can't be saved"
      redirect_to :back
    end
  end

  def show
    @warehouse = Warehouse.find(params[:id])
  end 

  def edit
    @warehouse = Warehouse.find(params[:id])
    @warehouse_types = WarehouseType.all
  end

  def update
    @warehouse = Warehouse.find(params[:id])
    if @warehouse.update_attributes!(warehouse_params)
      flash[:notice] = "Warehouse updated"
      redirect_to warehouses_path
    else
      redirect_to :back
    end 
  end

  private
  def warehouse_params
    params.require(:warehouse).permit(:name, :labor_uuid, :warehouse_type_uuid, :address, :note, :active)
  end
end
