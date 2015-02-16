class WarehousesController < ApplicationController
  load_and_authorize_resource except: :create

  def index
    begin
      @warehouse = Warehouse.new

      if params[:warehouse] and params[:warehouse][:name] and !params[:warehouse][:name].nil?
        @warehouses = Warehouse.find_by_warehouse_name(params[:warehouse][:name]).page(params[:page]).per(5)
      else
        @warehouses = Warehouse.page(params[:page]).per(5)
      end
    rescue Exception => e
      puts e
    end
  end

  def new
    begin
      @warehouse = Warehouse.new
      @warehouse_types = WarehouseType.all
      @workers = User.all
    rescue Exception => e
      puts e
    end
  end

  def create
    begin
      @warehouse = Warehouse.new(warehouse_params)

      if @warehouse.save!
        flash[:notice] = "Warehouse saved successfully"
        redirect_to warehouses_path
      else
        flash[:notice] = "Warehouse can't be saved"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  def edit
    begin
      @warehouse = Warehouse.find(params[:id])
      @warehouse_types = WarehouseType.all
      @workers = User.all
    rescue Exception => e
      puts e
    end
  end

  def update
    begin
      @warehouse = Warehouse.find(params[:id])

      if @warehouse.update_attributes!(warehouse_params)
        flash[:notice] = "Warehouse updated"
        redirect_to warehouses_path
      else
        flash[:notice] = "Warehouse can't update"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  def destroy
    @warehouse = Warehouse.find(params[:id])
    @warehouse.destroy

    respond_to do |format|
      format.html { redirect_to warehouses_path, :notice => 'Warehouse was successfully deleted.' }
      format.json { render json: @warehouse, status: :created, location: @warehouse }
    end
  end

  private
  def warehouse_params
    params.require(:warehouse).permit(:name, :labor_uuid, :warehouse_type_uuid, :address, :note, :active)
  end
end
