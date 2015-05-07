class WarehouseMaterialAmountsController < ApplicationController
  load_and_authorize_resource except: :create
  
  add_breadcrumb "Material In Stock", :warehouse_material_amounts_path
  
  def index
    begin
      central_uuid = WarehouseType.find_by_name("Central Warehouse").uuid 
      project_uuid = WarehouseType.find_by_name("Project Warehouse").uuid
      fertilizer_uuid = WarehouseType.find_by_name("Fertilizer Warehouse").uuid
      @warehouses = Warehouse.where("warehouse_type_uuid = ? and active = ? OR warehouse_type_uuid = ? and active = ? OR warehouse_type_uuid = ? and active = ?", central_uuid, true, project_uuid, true, fertilizer_uuid, true)
    rescue Exception => e
      puts e
    end
  end
  
  def edit
    begin
      @warehouse_material_amount = WarehouseMaterialAmount.find(params[:id])
    rescue Exception => e
      puts e
    end
  end

  def update
    adjust_date = Date.today
    wha_id = @warehouse_material_amount.uuid
    old_amount = @warehouse_material_amount.amount
    new_amount = params[:warehouse_material_amount][:amount]
    user_id = current_user.uuid
    user_name = User.find(current_user.uuid).email
    note = params[:material_note]
    
    if @warehouse_material_amount.update(amount: params[:warehouse_material_amount][:amount])
      MaterialAdjustment.create(adjust_date: adjust_date,  warehouse_material_amount_id: wha_id, old_amount: old_amount, new_amount: new_amount, user_id: user_id, user_name: user_name, note: note)
      redirect_to warehouse_material_amounts_path+"?wha_id="+wha_id
    else
      flash[:notice] = "Stock can not be adjusted"
    end
  end
  
  def get_warehouse_material_amount_data
    render json: WarehouseMaterialAmount.find_by(warehouse_uuid: params[:warehouse_id], material_uuid: params[:material_id])
  end
end
