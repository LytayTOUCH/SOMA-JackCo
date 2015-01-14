class WarehouseTypesController < ApplicationController
  load_and_authorize_resource except: :create
  
  def index
    begin
      @warehouse_type = WarehouseType.new

      if params[:warehouse_type] and params[:warehouse_type][:name] and !params[:warehouse_type][:name].nil?
        @warehouse_types = WarehouseType.find_by_name(params[:warehouse_type][:name]).page(params[:page]).per(5)
      else
        @warehouse_types = WarehouseType.page(params[:page]).per(5)
      end
    rescue Exception => e
      puts e
    end
  end

  def new
    @warehouse_type = WarehouseType.new
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
    @warehouse_type = WarehouseType.find(params[:id])
  end

  def update
    begin
      @warehouse_type = WarehouseType.find(params[:id])

      if @warehouse_type.update_attributes!(warehouse_type_params)
        flash[:notice] = "WarehouseType updated"
        redirect_to warehouse_types_path
      else
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
