class MaterialsController < ApplicationController
  load_and_authorize_resource except: :create
  
  add_breadcrumb "All Materials", :materials_path

  def index
    @materials = Material.joins(:material_category).order("materials.material_cate_uuid, materials.created_at desc")
  end

  def new
    begin
      @material = Material.new
      @material_categories = MaterialCategory.all
      @unit_measurements = UnitOfMeasurement.all
    rescue Exception => e
      puts e
    end
  end

  def create
    begin
      @material = Material.new(material_params)

      central_id = WarehouseType.find_by(name: 'Central Warehouse').uuid
      fertilizer_id = WarehouseType.find_by(name: 'Fertilizer Warehouse').uuid
      project_id = WarehouseType.find_by(name: 'Project Warehouse').uuid
      
      material_warehouses = Warehouse.where("warehouse_type_uuid = ? OR warehouse_type_uuid = ? OR warehouse_type_uuid = ?", central_id, fertilizer_id, project_id)

      if @material.save
        create_log current_user.uuid, "Created New Material", @material
        
        material_warehouses.each do |warehouse|
          # WAREHOUSE MATERIAL AMOUNT
          WarehouseMaterialAmount.create(warehouse_uuid: warehouse.uuid,  material_uuid: @material.uuid, amount: 0, returnable: false)
        end
        
        proj_wh = Warehouse.where("warehouse_type_uuid = ?", WarehouseType.find_by(name: 'Project Warehouse').uuid)
        proj_wh.each do |warehouse|
          # STOCK BALANCE
          start_month = 1
          this_month = Date.today.month
          while start_month <= this_month do
            StockBalance.create_with(material_category_id: @material.material_cate_uuid, stock_in: 0, stock_out: 0, beginning_balance: 0, ending_balance: 0).find_or_create_by(material_id: @material.uuid, warehouse_id: warehouse.uuid, month: start_month, year: Date.today.year)
            start_month += 1
          end
        end
        
        flash[:notice] = "Material saved successfully"
        redirect_to materials_path
      else
        flash[:notice] = "Material can't be saved"
        render 'new'
      end
    rescue Exception => e
      puts e
    end
  end

  def edit
    begin
      @material = Material.find(params[:id])
      @material_categories = MaterialCategory.all
      @unit_measurements = UnitOfMeasurement.all
      add_breadcrumb @material.name, :edit_material_path
    rescue Exception => e
      puts e
    end
  end

  def update
    begin
      @material = Material.find(params[:id])

      if @material.update_attributes(material_params)
        create_log current_user.uuid, "Updated Material", @material
        flash[:notice] = "Material updated successfully"
        redirect_to materials_path
      else
        flash[:notice] = "Material can't be updated."
        render 'edit'
      end
    rescue Exception => e
      puts e
    end
  end

  def get_material_name
    @material_name = Material.find_by_uuid(params[:material_uuid])
    @project_warehouse_type = WarehouseType.find_by_name("Project Warehouse")
    # @project_warehouses = Warehouse.where(warehouse_type_uuid: @project_warehouse_type.uuid)
    @project_warehouses = Warehouse.where(warehouse_type_uuid: @project_warehouse_type.uuid, active: true)
    @material_uom = Material.find_by_uuid(params[:material_uuid]).unit_of_measurement
    render :json => {warehouse: @project_warehouses,material_name: @material_name, material_uom: @material_uom}
  end

  def get_material_data
    @material_data = Material.where(material_cate_uuid: params[:material_cate_uuid])
    render :json => @material_data
  end

  def get_material_uom_data
    @material_data = Material.find_by_uuid(params[:material_uuid]).unit_of_measurement
    render :json => @material_data
  end

  private
  def material_params
    params.require(:material).permit(:name, :material_cate_uuid, :unit_measure_uuid, :supplier, :note)
  end
end
