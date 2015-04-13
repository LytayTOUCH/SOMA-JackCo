class MaterialsController < ApplicationController
  load_and_authorize_resource except: :create
  
  add_breadcrumb "All Materials", :materials_path

  def index
    @materials = Material.order('updated_at DESC')
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
        material_warehouses.each do |warehouse|
          WarehouseMaterialAmount.create(warehouse_uuid: warehouse.uuid,  material_uuid: @material.uuid, amount: 0, returnable: false)
        end
        flash[:notice] = "Material saved successfully"
        redirect_to materials_path
      else
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
        flash[:notice] = "Material updated successfully"
        redirect_to materials_path
      else
        render 'edit'
      end
    rescue Exception => e
      puts e
    end
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
