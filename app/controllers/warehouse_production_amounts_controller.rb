class WarehouseProductionAmountsController < ApplicationController
  load_and_authorize_resource except: :create
  
  add_breadcrumb "Product In Stock", :warehouse_production_amounts_path
  
  def index
    begin
      finish_uuid = WarehouseType.find_by_name("Finished Goods Warehouse").uuid 
      nursery_uuid = WarehouseType.find_by_name("Nursery Warehouse").uuid
      @warehouses = Warehouse.where("warehouse_type_uuid = ? and active = ? OR warehouse_type_uuid = ? and active = ?", finish_uuid, true, nursery_uuid, true)
    rescue Exception => e
      puts e
    end
  end
end
