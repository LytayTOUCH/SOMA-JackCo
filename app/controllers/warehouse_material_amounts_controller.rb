require 'date'

class WarehouseMaterialAmountsController < ApplicationController
  load_and_authorize_resource except: :create
  
  add_breadcrumb "Set Material In Stock", :warehouse_material_amounts_path
  
  def index
    begin
      central_uuid = WarehouseType.find_by_name("Central Warehouse").uuid 
      project_uuid = WarehouseType.find_by_name("Project Warehouse").uuid
      fertilizer_uuid = WarehouseType.find_by_name("Fertilizer Warehouse").uuid
      @warehouses = Warehouse.where("warehouse_type_uuid = ? and active = ? OR warehouse_type_uuid = ? and active = ? OR warehouse_type_uuid = ? and active = ?", central_uuid, true, project_uuid, true, fertilizer_uuid, true)
      
      if params[:warehouse] and params[:warehouse][:uuid] and !params[:warehouse][:uuid].nil?
        @material_categories = MaterialCategory.all
        @selected_warehouse = Warehouse.find_by_uuid(params[:warehouse][:uuid])
        @warehouse_material_amounts = WarehouseMaterialAmount.find_by_warehouse(params[:warehouse][:uuid])
      else
        @selected_warehouse = Warehouse.new
        @warehouse_material_amounts = nil
      end
    rescue Exception => e
      puts e
    end
  end
  
  def edit
    @warehouse_material_amount = WarehouseMaterialAmount.find(params[:id])
    @uom_name = @warehouse_material_amount.material.unit_of_measurement.name
    session[:return_to] ||= request.referer
  end
  
  def update
    begin
      @warehouse_material_amount = WarehouseMaterialAmount.find(params[:id])
      
      if @warehouse_material_amount.update_attributes!(warehouse_material_amount_params)
        flash[:notice] = "Stock adjusted successfully"
      else
        flash[:notice] = "Stock can't be adjusted"
      end
      
      redirect_to session.delete(:return_to)
      
    rescue Exception => e
      puts e
    end
  end

  private
  def warehouse_material_amount_params
    params.require(:warehouse_material_amount).permit(:amount)
  end
end
