class StockInsController < ApplicationController
  load_and_authorize_resource except: :create

  add_breadcrumb "All Stock In", :stock_ins_path

  def index
    @stock_in = StockIn.new
    @stock_ins = StockIn.order(stock_in_date: :desc)
  end

  def new
    begin
      central_uuid = WarehouseType.find_by_name("Central Warehouse").uuid 
      project_uuid = WarehouseType.find_by_name("Project Warehouse").uuid
      fertilizer_uuid = WarehouseType.find_by_name("Fertilizer Warehouse").uuid
      
      @warehouses = Warehouse.where("warehouse_type_uuid = ? and active = ? OR warehouse_type_uuid = ? and active = ? OR warehouse_type_uuid = ? and active = ?", central_uuid, true, project_uuid, true, fertilizer_uuid, true)
      
      @stock_in = StockIn.new
      @materials = Material.all
      @labors = Labor.all
    rescue Exception => e
      puts e
    end
  end

  def show
    @stock_in = StockIn.find(params[:id])
    add_breadcrumb @stock_in.name, :stock_in_path
  end

  def create
    begin
      @stock_in = StockIn.new(stock_in_params)

      if @stock_in.save!
        @warehouse_material_amount = WarehouseMaterialAmount.find_by(warehouse_uuid: @stock_in.warehouse.uuid, material_uuid: @stock_in.material.uuid)

        stock_in_amount = @stock_in.amount
        total_amount = @warehouse_material_amount.amount + stock_in_amount

        @warehouse_material_amount.update_attributes!(warehouse_uuid: @stock_in.warehouse.uuid, material_uuid: @stock_in.material.uuid, amount: total_amount)

        flash[:notice] = "Stock In saved successfully"
        redirect_to stock_ins_path
      else
        flash[:notice] = "No such material in Stock"
        flash[:notice] = "Stock In can't be saved"
        render 'new'
      end
    rescue Exception => e
      puts e
    end
  end

  private
  def stock_in_params
    params.require(:stock_in).permit(:warehouse_id, :labor_id, :material_id, :amount, :stock_in_date, :reference_number, :item_desc, :note)
  end

end
