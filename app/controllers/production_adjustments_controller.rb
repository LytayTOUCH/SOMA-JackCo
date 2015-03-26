class ProductionAdjustmentsController < ApplicationController
  def index
    @production_adjustments = ProductionAdjustment.order(created_at: :desc)
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
    params.require(:production_adjustment).permit(:adjust_date, :warehouse_production_amount_id, :old_amount, :new_amount, :user_id, :user_name, :note)
  end
end
