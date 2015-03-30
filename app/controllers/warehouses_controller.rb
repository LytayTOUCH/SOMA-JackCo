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
      @workers = User.all
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
        flash[:notice] = "Warehouse can't be saved"
        # redirect_to :back
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
      @workers = User.all
      add_breadcrumb @warehouse.name, :edit_warehouse_path
    rescue Exception => e
      puts e
    end
  end

  def update
    begin
      @warehouse = Warehouse.find(params[:id])

      if @warehouse.update_attributes(warehouse_params)
        flash[:notice] = "Warehouse updated"
        redirect_to warehouses_path
      else
        flash[:notice] = "Warehouse can't be updated"
        # redirect_to :back
        render 'edit'
      end
    rescue Exception => e
      puts e
    end
  end

  def destroy
    @warehouse = Warehouse.find(params[:id])
    @warehouse.destroy

    respond_to do |format|
      format.html { redirect_to warehouses_path, :notice => 'Warehouse was successfully deleted.' }
      format.json { render json: @warehouse, status: :created, location: @warehouse }
    end
  end

  def get_warehouses_data
    @warehouse_datas = Machinery.where(:warehouse_id => params[:warehouse_id])
    render :json => @warehouse_datas
  end

  private
  def warehouse_params
    params.require(:warehouse).permit(:name, :labor_uuid, :warehouse_type_uuid, :address, :note, :active)
  end
end
