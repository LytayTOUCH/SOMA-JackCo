class ProductionsController < ApplicationController
  load_and_authorize_resource except: :create

  add_breadcrumb "All Productions", :productions_path

  def index
    @productions = Production.order(created_at: :desc)
  end

  def new
    @production = Production.new
  end

  def show
    @production = Production.find(params[:id])
    add_breadcrumb @production.name, :production_path
  end

  def create
    begin
      @production = Production.new(production_params)
      
      finished_id = WarehouseType.find_by_name("Finished Goods Warehouse").uuid 
      nursery_id = WarehouseType.find_by_name("Nursery Warehouse").uuid

      production_warehouses = Warehouse.where("warehouse_type_uuid = ? OR warehouse_type_uuid = ?", finished_id, nursery_id) 

      if @production.save
        production_warehouses.each do |warehouse|
          WarehouseProductionAmount.create(warehouse_id: warehouse.uuid, production_id: @production.uuid, amount: 0)
        end 
        flash[:notice] = "Production saved successfully"
        redirect_to productions_path
      else
        render 'new'
      end
    rescue Exception => e
      puts e
    end
  end

  def edit
    @production = Production.find(params[:id])
  end

  def update
    begin
      @production = Production.find(params[:id])

      if @production.update_attributes(production_params)
        flash[:notice] = "Production updated"
        redirect_to productions_path
      else
        render 'edit'
      end
    rescue Exception => e
      puts e
    end
  end

  private
  def production_params
    params.require(:production).permit(:status, :planting_project_id, :uom_id, :note)
  end
end
