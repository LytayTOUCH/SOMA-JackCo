class WarehouseTypesController < ApplicationController
  def index
    @warehousetypes = WarehouseType.all
  end

  def new
    @warehouse_type = WarehouseType.new
  end

  def create   
    @warehousetype = WarehouseType.new(warehouse_type_params)
    if @warehousetype.save!
      # flash[:notice] = "Warehouse type saved successfully"
      redirect_to warehouse_types_path
    else
      flash[:notice] = "Warehouse type can't save"
      redirect_to :back
    end
  end

  def show
    @warehousetype = WarehouseType.find(params[:id])
  end

  def edit
    @warehousetype = WarehouseType.find(params[:id])
  end

  def update
    # Find object using form parameters
    #@WarehouseType = WarehouseType.new(params[:WarehouseType])
    # puts "hellooooooooooooooooooooooooooooo"
    @warehousetype = WarehouseType.find(params[:id])
    # Save the object
    if @warehousetype.update_attributes(warehouse_type_params)
      # Showing text
      flash[:notice] = "WarehouseType updated."
      # If save succeeds, redirect to the list action
      redirect_to warehouse_types_path
    else
      # If save fails, redisplay the form so user can fix problems
      # @WarehouseType_count = WarehouseType.count
      render('edit')
    end 
  end

  private
  def warehouse_type_params
    params.require(:warehouse_type).permit(:name, :description, :active)
  end
end
