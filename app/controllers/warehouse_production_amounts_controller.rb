class WarehouseProductionAmountsController < ApplicationController
  load_and_authorize_resource except: :create
  
  add_breadcrumb "Product In Stock", :warehouse_production_amounts_path
  
  def index
    begin
      finish_uuid = WarehouseType.find_by_name("Finished Goods Warehouse").uuid 
      nursery_uuid = WarehouseType.find_by_name("Nursery Warehouse").uuid
      @warehouses = Warehouse.where("warehouse_type_uuid = ? and active = ? OR warehouse_type_uuid = ? and active = ?", finish_uuid, true, nursery_uuid, true)
      
      if params[:warehouse] and params[:warehouse][:uuid] and !params[:warehouse][:uuid].nil?
        @selected_warehouse = Warehouse.find_by_uuid(params[:warehouse][:uuid])
        @planting_projects = @selected_warehouse.planting_projects.distinct
      else
        @selected_warehouse = Warehouse.new
        @warehouse_production_amounts = nil
      end
    rescue Exception => e
      puts e
    end
  end
end
