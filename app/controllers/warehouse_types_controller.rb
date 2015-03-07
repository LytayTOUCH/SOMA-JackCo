class WarehouseTypesController < ApplicationController
  load_and_authorize_resource except: :create

  add_breadcrumb "All Warehouse Types", :warehouse_types_path
  
  def index
    begin
      @warehouse_type = WarehouseType.new

      if params[:warehouse_type] and params[:warehouse_type][:name] and !params[:warehouse_type][:name].nil?
        @warehouse_types = WarehouseType.find_by_warehouse_type_name(params[:warehouse_type][:name]).page(params[:page]).per(session[:item_per_page])
      else
        @warehouse_types = WarehouseType.page(params[:page]).per(session[:item_per_page])
      end
    rescue Exception => e
      puts e
    end
  end

  def new
    begin
      @warehouse_type = WarehouseType.new
    rescue Exception => e
      puts e
    end
  end

  def create
    begin
      @warehouse_type = WarehouseType.new(warehouse_type_params)

      if @warehouse_type.save!
        flash[:notice] = "Warehouse type saved successfully"
        redirect_to warehouse_types_path
      else
        flash[:notice] = "Warehouse type can't save"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  def edit
    begin
      @warehouse_type = WarehouseType.find(params[:id])
      add_breadcrumb @warehouse_type.name, :edit_warehouse_type_path
    rescue Exception => e
      puts e
    end
  end

  def update
    begin
      @warehouse_type = WarehouseType.find(params[:id])

      if @warehouse_type.update_attributes!(warehouse_type_params)
        flash[:notice] = "WarehouseType updated"
        redirect_to warehouse_types_path
      else
        flash[:notice] = "WarehouseType can't be updated"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  private
  def warehouse_type_params
    params.require(:warehouse_type).permit(:name, :note, :active)
  end
end
