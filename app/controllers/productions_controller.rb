class ProductionsController < ApplicationController
  load_and_authorize_resource except: :create

  add_breadcrumb "All Productions", :productions_path

  def index
    begin
      @production = Production.new

      if params[:production] and params[:production][:name] and !params[:production][:name].nil?
        @productions = Production.find_by_production_name(params[:production][:name]).page(params[:page]).per(session[:item_per_page])
      else
        @productions = Production.page(params[:page]).per(session[:item_per_page])
      end
    rescue Exception => e
      puts e
    end
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
      # @production.warehouse_ids = params[:production][:warehouse_ids]   
      @finished_warehouse = WarehouseType.find_by_name("Finished Goods Warehouse") 
      @nursery_warehouse = WarehouseType.find_by_name("Nursery Warehouse") 

      @production_warehouses = Warehouse.where("warehouse_type_uuid = ? OR warehouse_type_uuid = ?", @finished_warehouse.uuid, @nursery_warehouse.uuid) 

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
      @production.warehouse_ids = params[:production][:warehouse_ids]      

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
