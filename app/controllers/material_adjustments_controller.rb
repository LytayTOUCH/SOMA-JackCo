class MaterialAdjustmentsController < ApplicationController
  
  def new
    @material_adjustment = MaterialAdjustment.new
    @warehouse_material_amount = WarehouseMaterialAmount.find(params[:id])
    @uom_name = @warehouse_material_amount.material.unit_of_measurement.name
    session[:return_to] ||= request.referer
  end
  
  def create
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
