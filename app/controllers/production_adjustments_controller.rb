class ProductionAdjustmentsController < ApplicationController
  def index
    finish_uuid = WarehouseType.find_by_name("Finished Goods Warehouse").uuid 
    nursery_uuid = WarehouseType.find_by_name("Nursery Warehouse").uuid
    @warehouses = Warehouse.where("warehouse_type_uuid = ? and active = ? OR warehouse_type_uuid = ? and active = ?", finish_uuid, true, nursery_uuid, true)
    
    if params[:warehouse] and params[:warehouse][:uuid] and params[:warehouse][:uuid] != "" and !params[:warehouse][:uuid].nil?
      @selected_warehouse = Warehouse.find_by_uuid(params[:warehouse][:uuid])
      @production_adjustments = ProductionAdjustmentDecorator.new(ProductionAdjustment.find_by_warehouse(params[:warehouse][:uuid]).page(params[:page]).per(session[:item_per_page]))
    else
      @selected_warehouse = Warehouse.new
      @production_adjustments = ProductionAdjustmentDecorator.new(ProductionAdjustment.order(created_at: :desc).page(params[:page]).per(session[:item_per_page]))
    end
  end
  
  def new
    warehouse_production_amount = WarehouseProductionAmount.find(params[:id])
    
    @production_adjustment = ProductionAdjustment.new
    
    @production_adjustment.new_amount = warehouse_production_amount.amount
    @production_adjustment.old_amount = warehouse_production_amount.amount
    @production_adjustment.warehouse_production_amount_id = warehouse_production_amount.uuid
    
    user = User.find(current_user.uuid)
    @production_adjustment.user_name = user.email
    
    @uom_name = warehouse_production_amount.production.unit_of_measurement.name
    session[:return_to] ||= request.referer
  end
  
  def create
    begin
      @warehouse_production_amount = WarehouseProductionAmount.find(params[:production_adjustment][:warehouse_production_amount_id])
      @warehouse_production_amount.update_attributes!(amount: params[:production_adjustment][:new_amount])
      
      @production_adjustment = ProductionAdjustment.new(production_adjustment_params)
      
      if @production_adjustment.save!
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
  def production_adjustment_params
    params.require(:production_adjustment).permit(:adjust_date, :warehouse_production_amount_id, :old_amount, :new_amount, :user_id, :user_name)
  end
end
