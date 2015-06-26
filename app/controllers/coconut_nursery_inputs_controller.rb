class CoconutNurseryInputsController < ApplicationController
  def index
    @cs = CoconutNurseryInput.order("created_at DESC")
  end

  def new
    @c = CoconutNurseryInput.new
  end
  
  def create
    @c = CoconutNurseryInput.new(nursery_params)
    @c.qty_in_stock = params[:qty_in_stock].nil? ? 0 : params[:qty_in_stock].to_i
    if @c.save
      create_log current_user.uuid, "Created New Nursery Data", @c
      
      # 00000000-0000-0000-0000-000000000011 - is Coconut To Nursery Warehouse
      production_in_wh = ProductionInWarehouse.find_by(warehouse_id: @c.warehouse_id, distribution_id: "00000000-0000-0000-0000-000000000011", unit_measure_id: UnitOfMeasurement.find_by_name("Unit").uuid)
      new_amount = production_in_wh.amount - @c.input_total_qty
      production_in_wh.update_attributes(:amount => new_amount)
      
      flash[:notice] = "Nursery Data saved successfully"
      redirect_to coconut_nursery_inputs_path
    else
      flash[:notice] = "Nursery Data can't be saved."
      render 'new'
    end
  end
  
  private
  def nursery_params
    params.require(:coconut_nursery_input).permit(:reference_number, :nursery_date, :item_name, :warehouse_id, :input_total_qty, :input_processing_qty, :input_spoil_qty, :receive_date)
  end
end
