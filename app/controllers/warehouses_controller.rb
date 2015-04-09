class WarehousesController < ApplicationController
  load_and_authorize_resource except: :create

  add_breadcrumb "All Warehouses", :warehouses_path

  def index
    @warehouses = Warehouse.order('updated_at DESC')
  end

  def new
    begin
      @warehouse = Warehouse.new
      @warehouse_types = WarehouseType.all
    rescue Exception => e
      puts e
    end
  end

  def show
    @warehouse = Warehouse.find(params[:id])
    add_breadcrumb @warehouse.name, :warehouse_path
  end

  def create
    begin
      @warehouse = Warehouse.new(warehouse_params)

      @finishedGooduuid = WarehouseType.find_by_name("Finished Goods Warehouse").uuid
      @nurseryuuid = WarehouseType.find_by_name("Nursery Warehouse").uuid

      @productions = Production.all
      @materials = Material.all     

      if @warehouse.save
        
        create_log current_user.uuid, "Create New Warehouse", @warehouse
        
        if @warehouse.warehouse_type_uuid == @finishedGooduuid || @warehouse.warehouse_type_uuid == @nurseryuuid
          @productions.each do |production|
            WarehouseProductionAmount.create(warehouse_id: @warehouse.uuid, production_id: production.uuid, amount: 0)
          end
        else
          @materials.each do |material|
            WarehouseMaterialAmount.create(warehouse_uuid: @warehouse.uuid, material_uuid: material.uuid, amount: 0, returnable: false)
          end
        end

        flash[:notice] = "Warehouse saved successfully"
        redirect_to warehouses_path
      else
        render 'new'
      end
    rescue Exception => e
      puts e
    end
  end

  def edit
    begin
      @warehouse = Warehouse.find(params[:id])
      @warehouse_types = WarehouseType.all
      add_breadcrumb @warehouse.name, :edit_warehouse_path
    rescue Exception => e
      puts e
    end
  end

  def update
    begin
      @warehouse = Warehouse.find(params[:id])

      if @warehouse.update_attributes(warehouse_params)
        
        create_log current_user.uuid, "Update Warehouse", @warehouse
        
        flash[:notice] = "Warehouse updated"
        redirect_to warehouses_path
      else
        render 'edit'
      end
    rescue Exception => e
      puts e
    end
  end

  private
  def warehouse_params
    params.require(:warehouse).permit(:name, :labor_uuid, :warehouse_type_uuid, :address, :note, :active)
  end
end
