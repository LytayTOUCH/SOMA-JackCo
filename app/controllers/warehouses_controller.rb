class WarehousesController < ApplicationController
  load_and_authorize_resource except: [:create, :get_qty_production_in_stock, :get_project_warehouse_data]

  add_breadcrumb "All Warehouses", :warehouses_path

  def index
    @warehouses = Warehouse.order('updated_at DESC')
  end

  def new
    begin
      @warehouse = Warehouse.new
      @warehouse_types = WarehouseType.all
    rescue Exception => e
      puts e
    end
  end

  def show
    @warehouse = Warehouse.find(params[:id])
    add_breadcrumb @warehouse.name, :warehouse_path
  end

  def create
    begin
      @warehouse = Warehouse.new(warehouse_params)
      @finishedGooduuid = WarehouseType.find_by_name("Finished Goods Warehouse").uuid
      @nurseryuuid = WarehouseType.find_by_name("Nursery Warehouse").uuid

      @productions = Production.all
      @materials = Material.all     

      if @warehouse.save
        create_log current_user.uuid, "Created New Warehouse", @warehouse
        
        unit = UnitOfMeasurement.find_by_name('Unit')
        
        if @warehouse.warehouse_type_uuid == @finishedGooduuid
          
          # UPDATE TO FINISH WAREHOUSE
          #To Finish Good Warehouse - Coconut    , To Finish Good Warehouse - Jackfruit
          ['00000000-0000-0000-0000-000000000008', '00000000-0000-0000-0000-000000000019'].each do |distribution_id|
            ProductionInWarehouse.create_with(amount: 0).find_or_create_by(warehouse_id: @warehouse.uuid, distribution_id: distribution_id, unit_measure_id: unit.uuid)
          end
          
        elsif @warehouse.warehouse_type_uuid == @nurseryuuid
          
          # UPDATE TO NURSERY WAREHOUSE
          #To Nursery Warehouse - Coconut        , To Nursery Warehouse - Jackfruit
          ['00000000-0000-0000-0000-000000000011', '00000000-0000-0000-0000-000000000018'].each do |distribution_id|
            ProductionInWarehouse.create_with(amount: 0).find_or_create_by(warehouse_id: @warehouse.uuid, distribution_id: distribution_id, unit_measure_id: unit.uuid)
          end
          
        else
          @materials.each do |material|
            # WAREHOUSE MATERIAL AMOUNT
            WarehouseMaterialAmount.create(warehouse_uuid: @warehouse.uuid, material_uuid: material.uuid, amount: 0, returnable: false)
            
            if @warehouse.warehouse_type_uuid == WarehouseType.find_by(name: 'Project Warehouse').uuid
              # STOCK BALANCE
              start_month = 1
              this_month = Date.today.month
              while start_month <= this_month do
                StockBalance.create_with(material_category_id: material.material_cate_uuid, stock_in: 0, stock_out: 0, beginning_balance: 0, ending_balance: 0).find_or_create_by(material_id: material.uuid, warehouse_id: @warehouse.uuid, month: start_month, year: Date.today.year)
                start_month += 1
              end
            end
          end
        end
        
        flash[:notice] = "Warehouse saved successfully"
        redirect_to warehouses_path
      else
        render 'new'
      end
    rescue Exception => e
      puts e
    end
  end

  def edit
    begin
      @warehouse = Warehouse.find(params[:id])
      @warehouse_types = WarehouseType.all
      add_breadcrumb @warehouse.name, :edit_warehouse_path
    rescue Exception => e
      puts e
    end
  end

  def update
    begin
      @warehouse = Warehouse.find(params[:id])

      if @warehouse.update_attributes(warehouse_params)  
        if params[:warehouse][:active] == "false"
          create_log current_user.uuid, "Deactivated Warehouse", @warehouse
        elsif params[:warehouse][:active] == "true"
          create_log current_user.uuid, "Activated Warehouse", @warehouse
        end

        if params[:warehouse][:active] == "1" or params[:warehouse][:active] == "0"
          create_log current_user.uuid, "Updated Warehouse", @warehouse  
        end
        flash[:notice] = "Warehouse updated"
        redirect_to warehouses_path
      else
        flash[:notice] = "Warehouse can't be updated"
        render 'edit'
      end
    rescue Exception => e
      puts e
    end
  end
  
  def get_qty_production_in_stock
    unit_id = UnitOfMeasurement.find_by_name("Unit").uuid
    render json: ProductionInWarehouse.find_by(warehouse_id: params[:warehouse_id], distribution_id: params[:distribution_id], unit_measure_id: unit_id)
  end

  def get_project_warehouse_data
    render :json => Warehouse.where(warehouse_type_uuid: WarehouseType.find_by_name("Project Warehouse").uuid, active: true)
  end
  
  private
  def warehouse_params
    params.require(:warehouse).permit(:name, :labor_uuid, :warehouse_type_uuid, :address, :note, :active)
  end
end
