class WarehouseMaterialAmountsController < ApplicationController
  load_and_authorize_resource except: :create
  
  add_breadcrumb "Material In Stock", :warehouse_material_amounts_path
  
  def index
    begin
      central_uuid = WarehouseType.find_by_name("Central Warehouse").uuid 
      project_uuid = WarehouseType.find_by_name("Project Warehouse").uuid
      fertilizer_uuid = WarehouseType.find_by_name("Fertilizer Warehouse").uuid
      @warehouses = Warehouse.where("warehouse_type_uuid = ? and active = ? OR warehouse_type_uuid = ? and active = ? OR warehouse_type_uuid = ? and active = ?", central_uuid, true, project_uuid, true, fertilizer_uuid, true)
      
      if params[:warehouse] and params[:warehouse][:uuid] and !params[:warehouse][:uuid].nil?
        @selected_warehouse = Warehouse.find_by_uuid(params[:warehouse][:uuid])
        @material_categories = @selected_warehouse.material_categories.distinct
      else
        @selected_warehouse = Warehouse.new
        @warehouse_material_amounts = nil
      end
    rescue Exception => e
      puts e
    end
  end
end
