class WarehousesController < ApplicationController
  def index
    @warehouses = Warehouse.all
  end

  def new
    @warehouse = Warehouse.new
    @warehouse_types = WarehouseType.all
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)
    if @warehouse.save!
      # flash[:notice] = "Warehouse type saved successfully"
      redirect_to warehouses_path
    else
      flash[:notice] = "Warehouse can't save"
      redirect_to :back
    end
  end
  # 271E9306-7160-11E4-B739-E0DB55A6E603

  def show
    @warehouse = Warehouse.find(params[:id])
  end 

  def edit
    @warehouse = Warehouse.find(params[:id])
    @warehouse_types = WarehouseType.all
  end

  def update
    # Find object using form parameters
    #@WarehouseType = WarehouseType.new(params[:WarehouseType])
    # puts "hellooooooooooooooooooooooooooooo"
    @warehouse = Warehouse.find(params[:id])
    # Save the object
    if @warehouse.update_attributes(warehouse_params)
      # Showing text
      flash[:notice] = "Warehouse updated."
      # If save succeeds, redirect to the list action
      redirect_to warehouses_path
    else
      # If save fails, redisplay the form so user can fix problems
      # @WarehouseType_count = WarehouseType.count
      render('edit')
    end 
  end

  private
  def warehouse_params
    params.require(:warehouse).permit(:name, :labor_uuid, :warehouse_type_uuid, :address, :description, :active)
    # params.require(:warehouse).permit(:name, warehouse_types_attributes: [:name], :supervisor_uuid, :warehouse_type_uuid, :address, :description, :active)
  end
end
