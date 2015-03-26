class ProductionsController < ApplicationController
  load_and_authorize_resource except: :create

  add_breadcrumb "All Productions", :productions_path

  def index
    @productions = Production.order(created_at: :desc)
  end

  def new
    begin
      @production = Production.new
      @planting_projects = PlantingProject.all
      @uom = UnitOfMeasurement.all
    rescue Exception => e
      puts e
    end
  end

  def show
    @production = Production.find(params[:id])
    add_breadcrumb @production.name, :production_path
  end

  def create
    begin
      @production = Production.new(production_params)
      @finished_warehouse = WarehouseType.find_by_name("Finished Goods Warehouse") 
      @nursery_warehouse = WarehouseType.find_by_name("Nursery Warehouse") 

      @production_warehouses = Warehouse.where("warehouse_type_uuid = ? and active = ? OR warehouse_type_uuid = ? and active = ?", @finished_warehouse.uuid, true, @nursery_warehouse.uuid, true) 

      if @production.save
        @production_warehouses.each do |warehouse|
          WarehouseProductionAmount.create(warehouse_id: warehouse.uuid, production_id: @production.uuid, amount: 0)
        end 
        flash[:notice] = "Production saved successfully"
        redirect_to productions_path
      else
        flash[:notice] = "Production can't be saved"
        # redirect_to :back
        render 'new'
      end
    rescue Exception => e
      puts e
    end
  end

  def edit
    begin
      @production = Production.find(params[:id])
      @planting_projects = PlantingProject.all
      @uom = UnitOfMeasurement.all
      add_breadcrumb @production.name, :edit_production_path
    rescue Exception => e
      puts e
    end
  end

  def update
    begin
      @production = Production.find(params[:id])

      if @production.update_attributes(production_params)
        flash[:notice] = "Production updated"
        redirect_to productions_path
      else
        flash[:notice] = "Production can't be updated"
        # redirect_to :back
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
