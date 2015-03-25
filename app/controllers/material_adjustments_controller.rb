class MaterialAdjustmentsController < ApplicationController
  def index
    central_uuid = WarehouseType.find_by_name("Central Warehouse").uuid 
    project_uuid = WarehouseType.find_by_name("Project Warehouse").uuid
    fertilizer_uuid = WarehouseType.find_by_name("Fertilizer Warehouse").uuid
    @warehouses = Warehouse.where("warehouse_type_uuid = ? and active = ? OR warehouse_type_uuid = ? and active = ? OR warehouse_type_uuid = ? and active = ?", central_uuid, true, project_uuid, true, fertilizer_uuid, true)
    
    if params[:warehouse] and params[:warehouse][:uuid] and params[:warehouse][:uuid] != "" and !params[:warehouse][:uuid].nil?
      @selected_warehouse = Warehouse.find_by_uuid(params[:warehouse][:uuid])
      @material_adjustments = MaterialAdjustmentDecorator.new(MaterialAdjustment.find_by_warehouse(params[:warehouse][:uuid]).order(created_at: :desc).page(params[:page]).per(session[:item_per_page]))
    else
      @selected_warehouse = Warehouse.new
      @material_adjustments = MaterialAdjustmentDecorator.new(MaterialAdjustment.order(created_at: :desc).page(params[:page]).per(session[:item_per_page]))
    end
  end
  
  def new
    warehouse_material_amount = WarehouseMaterialAmount.find(params[:id])
    
    @material_adjustment = MaterialAdjustment.new
    
    @material_adjustment.new_amount = warehouse_material_amount.amount
    @material_adjustment.old_amount = warehouse_material_amount.amount
    @material_adjustment.warehouse_material_amount_id = warehouse_material_amount.uuid
    
    user = User.find(current_user.uuid)
    @material_adjustment.user_name = user.email
    
    @uom_name = warehouse_material_amount.material.unit_of_measurement.name
    session[:return_to] ||= request.referer
  end
  
  def create
    begin
      @warehouse_material_amount = WarehouseMaterialAmount.find(params[:material_adjustment][:warehouse_material_amount_id])
      @warehouse_material_amount.update_attributes!(amount: params[:material_adjustment][:new_amount])
      
      @material_adjustment = MaterialAdjustment.new(material_adjustment_params)
      
      if @material_adjustment.save!
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
  def material_adjustment_params
    params.require(:material_adjustment).permit(:adjust_date, :warehouse_material_amount_id, :old_amount, :new_amount, :user_id, :user_name, :note)
  end
  
end
