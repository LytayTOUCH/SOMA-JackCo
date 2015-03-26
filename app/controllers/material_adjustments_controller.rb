class MaterialAdjustmentsController < ApplicationController
  def index
    @material_adjustments = MaterialAdjustment.order(created_at: :desc)
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
