class WarehouseMaterialAmountsController < ApplicationController
  load_and_authorize_resource except: :create
  
  add_breadcrumb "Set Material In Stock", :warehouse_material_amounts_path
  
  def index
    begin
      central_uuid = WarehouseType.find_by_name("Central Warehouse").uuid 
      project_uuid = WarehouseType.find_by_name("Project Warehouse").uuid
      fertilizer_uuid = WarehouseType.find_by_name("Fertilizer Warehouse").uuid
      @warehouses = Warehouse.where("warehouse_type_uuid = ? and active = ? OR warehouse_type_uuid = ? and active = ? OR warehouse_type_uuid = ? and active = ?", central_uuid, true, project_uuid, true, fertilizer_uuid, true)
      
      @warehouse_material_amount = WarehouseMaterialAmount.new
      
      if params[:warehouse_material_amount] and params[:warehouse_material_amount][:warehouse_uuid] and !params[:warehouse_material_amount][:warehouse_uuid].nil?
        @warehouse_material_amounts = LaborDecorator.new(WarehouseMaterialAmount.find_by_warehouse(params[:warehouse_material_amount][:warehouse_uuid]).page(params[:page]).per(session[:item_per_page]))
      else
        @warehouse_material_amounts = nil
      end
    rescue Exception => e
      puts e
    end
  end

  def new
  	# begin
  		# @warehouse_material_amount = WarehouseMaterialAmount.new
# 
      # @material_categories = MaterialCategory.all
#       
      # project_warehouse = WarehouseType.find_by(name: 'Project Warehouse')
      # central_warehouse = WarehouseType.find_by(name: 'Central Warehouse')
#       
      # @warehouses = Warehouse.where("(warehouse_type_uuid = '" + project_warehouse.uuid + "' or warehouse_type_uuid = '" + central_warehouse.uuid + "') and active=1")
#       
      # @warehouse_amount = @warehouses.count
# 
  	# rescue Exception => e
  		# puts e 		
  	# end
  end

  def create
  	# begin
  		# @warehouse_material_amount = WarehouseMaterialAmount.new(warehouse_material_amount_params)
# 
  		# if @warehouse_material_amount.save
  			# flash[:notice] = "Warehouse Material Amount saved successfully"
  			# redirect_to :back
  		# else
  			# flash[:notice] = "Warehouse Material Amount can't save"
  			# render 'new'
  		# end 		
  	# rescue Exception => e
  		# puts e
  	# end
  end

  # private
  # def warehouse_material_amount_params
  	# params.require(:warehouse_material_amount).permit(:warehouse_uuid, :material_uuid, :amount)
  # end

end
