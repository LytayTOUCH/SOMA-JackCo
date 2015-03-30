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
  
  def edit
    begin
      @warehouse_production_amount = WarehouseProductionAmount.find(params[:id])
    rescue Exception => e
      puts e
    end
  end

  def update
    adjust_date = Date.today
    wha_id = @warehouse_production_amount.uuid
    old_amount = @warehouse_production_amount.amount
    new_amount = params[:warehouse_production_amount][:amount]
    user_id = current_user.uuid
    user_name = User.find(current_user.uuid).email
    note = params[:production_note]
    
    if @warehouse_production_amount.update(amount: params[:warehouse_production_amount][:amount])
      ProductionAdjustment.create(adjust_date: adjust_date,  warehouse_production_amount_id: wha_id, old_amount: old_amount, new_amount: new_amount, user_id: user_id, user_name: user_name, note: note)
      redirect_to warehouse_production_amounts_path+"?wha_id="+wha_id
    else
      flash[:notice] = "Stock can not be adjusted"
    end
  end
end
