class WarehouseMaterialAmountsController < ApplicationController
  def index
  end

  def new
  	begin
  		@warehouse_material_amount = WarehouseMaterialAmount.new
  		@materials = Material.all
  		@warehouses = Warehouse.all  		
  	rescue Exception => e
  		puts e 		
  	end
  end

  def create
  	begin
  		@warehouse_material_amount = WarehouseMaterialAmount.new(warehouse_material_amount_params)

  		if @warehouse_material_amount.save
  			flash[:notice] = "Warehouse Material Amount saved successfully"
  			redirect_to :back
  		else
  			flash[:notice] = "Warehouse Material Amount can't save"
  			render 'new'
  		end 		
  	rescue Exception => e
  		puts e
  	end
  end

  private
  def warehouse_material_amount_params
  	params.require(:warehouse_material_amount).permit(:warehouse_uuid, :material_uuid, :amount)
  end

end
