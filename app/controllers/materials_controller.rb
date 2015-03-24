class MaterialsController < ApplicationController
  load_and_authorize_resource except: :create
  
  add_breadcrumb "All Materials", :materials_path

  def index
    begin
      @material = Material.new

      if params[:material] and params[:material][:name] and !params[:material][:name].nil?
        @materials = Material.find_by_material_name(params[:material][:name]).page(params[:page]).order('updated_at DESC').per(session[:item_per_page])
      else
        @materials = Material.page(params[:page]).order('updated_at DESC').per(session[:item_per_page])
      end
    rescue Exception => e
      puts e
    end
  end

  def new
    begin
      @material = Material.new
      # @suppliers = Supplier.all
      @material_categories = MaterialCategory.all
      @unit_measurements = UnitOfMeasurement.all
    rescue Exception => e
      puts e
    end
  end

  def create
    begin
      @material = Material.new(material_params)

      central_warehouse = WarehouseType.find_by(name: 'Central Warehouse')
      fertilizer_warehouse = WarehouseType.find_by(name: 'Fertilizer Warehouse')
      project_warehouse = WarehouseType.find_by(name: 'Project Warehouse')
      
      @material_warehouses = Warehouse.where("(warehouse_type_uuid = '" + central_warehouse.uuid + "' or warehouse_type_uuid = '" + fertilizer_warehouse.uuid + "' or warehouse_type_uuid = '" + project_warehouse.uuid + "') and active=1")

      if @material.save
        @material_warehouses.each do |warehouse|
          WarehouseMaterialAmount.create(warehouse_uuid: warehouse.uuid,  material_uuid: @material.uuid, amount: 0, returnable: false)
        end
        flash[:notice] = "Material saved successfully"
        # redirect_to :back
        redirect_to materials_path
      else
        flash[:notice] = "Material can't save"
        # redirect_to :back
        render 'new'
      end
    rescue Exception => e
      puts e
    end
  end

  # def create
  #   begin
  #     @material = Material.new(material_params)

  #     if @material.save
  #       flash[:notice] = "Material saved successfully"
  #       # redirect_to :back
  #       redirect_to materials_path
  #     else
  #       flash[:notice] = "Material can't save"
  #       # redirect_to :back
  #       render 'new'
  #     end
  #   rescue Exception => e
  #     puts e
  #   end
  # end

  def edit
    begin
      @material = Material.find(params[:id])
      # @suppliers = Supplier.all
      @material_categories = MaterialCategory.all
      @unit_measurements = UnitOfMeasurement.all
      add_breadcrumb @material.name, :edit_material_path
    rescue Exception => e
      puts e
    end
  end

  def update
    begin
      @material = Material.find(params[:id])

      if @material.update_attributes(material_params)
        flash[:notice] = "Material updated successfully"
        redirect_to materials_path
      else
        flash[:notice] = "Material can't update"
        # redirect_to :back
        render 'edit'
      end
    rescue Exception => e
      puts e
    end
  end

  def get_material_data
    @material_data = Material.where(material_cate_uuid: params[:material_cate_uuid])
    render :json => @material_data
  end

  def get_material_uom_data
    @material_data = Material.find_by_uuid(params[:material_uuid]).unit_of_measurement
    render :json => @material_data
  end

  # def new_supplier
  #   begin
  #     @supplier = Supplier.new
  #   rescue Exception => e
  #     puts e
  #   end
  # end

  private
  def material_params
    params.require(:material).permit(:name, :material_cate_uuid, :unit_measure_uuid, :supplier, :note)
  end
end
