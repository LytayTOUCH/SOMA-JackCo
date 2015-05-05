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
      create_log current_user.uuid, "Created New Warehouse", @warehouse

      @finishedGooduuid = WarehouseType.find_by_name("Finished Goods Warehouse").uuid
      @nurseryuuid = WarehouseType.find_by_name("Nursery Warehouse").uuid

      @productions = Production.all
      @materials = Material.all     

      if @warehouse.save
        create_log current_user.uuid, "Created New Warehouse", @warehouse
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
        if params[:warehouse][:active] == "false"
          create_log current_user.uuid, "Deactivated Warehouse", @warehouse
        elsif params[:warehouse][:active] == "true"
          create_log current_user.uuid, "Activated Warehouse", @warehouse
        end

        if params[:warehouse][:active] == "1" or params[:warehouse][:active] == "0"
          create_log current_user.uuid, "Updated Warehouse", @warehouse  
        end
        flash[:notice] = "Warehouse updated"
        redirect_to warehouses_path
      else
        flash[:notice] = "Warehouse can't be updated"
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
