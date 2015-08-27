class MachineriesController < ApplicationController
  load_and_authorize_resource except: [:create, :get_machinery_name, :get_input_machinery_data]
  add_breadcrumb "All Machineries", :machineries_path
  
  def index
    @machineries = Machinery.order(created_at: :desc)
  end
  
  def new
    @machinery = Machinery.new
  end
  
  def create
    begin
      @machinery = Machinery.new(machinery_params)

      if @machinery.save
        create_log current_user.uuid, "Created New Machinery", @machinery
        flash[:notice] = "Machinery saved successfully"
        redirect_to machineries_path
      else
        flash[:notice] = "Machinery can't be saved."
        render 'new'
      end
    rescue Exception => e
      puts e
    end
  end
  
  def edit
    @machinery = Machinery.find(params[:id])
    add_breadcrumb @machinery.name, :edit_machinery_path
  end
  
  def update
    begin
      @machinery = Machinery.find(params[:id])
      
      if @machinery.update_attributes(machinery_params)
        if params[:machinery][:status] == "false"
          create_log current_user.uuid, "Deactivated Machinery", @machinery
        elsif params[:machinery][:status] == "true"
          create_log current_user.uuid, "Activated Machinery", @machinery
        end

        if params[:machinery][:status] == "1" or params[:machinery][:status] == "0"
          create_log current_user.uuid, "Updated Machinery", @machinery  
        end 
        flash[:notice] = "Machinery updated successfully"
        redirect_to machineries_path
      else
        flash[:notice] = "Machinery can't be saved"
        render 'edit'
      end
    rescue Exception => e
      puts e
    end
  end

  def get_machinery_name
    @machinery_name = Machinery.find_by_uuid(params[:machinery_id])
    @project_warehouse_type = WarehouseType.find_by_name("Project Warehouse")
    @project_warehouses = Warehouse.where(warehouse_type_uuid: @project_warehouse_type.uuid, active: true)
    @materials = Material.where("material_cate_uuid = ? OR material_cate_uuid = ?", MaterialCategory.find_by_name("Indirect Materials").uuid, MaterialCategory.find_by_name("Other").uuid)
    render :json => {warehouse: @project_warehouses, machinery_name: @machinery_name, material: @materials}
    #TODO: This method will later return only machinery's data, and not project warehouse, indirect, and other materials anymore
  end
  
  def get_input_machinery_data
    machineries = Array.new
    Machinery.where("(planting_project_id = ? OR source = 'Service Supply') AND status = ?", params[:planting_project_id], true).each do |m|
      input_use_machinery = InputUseMachinery.find_by(input_id: params[:input_task_id], machinery_id: m.uuid)
      selected = input_use_machinery.nil? ? false : true
      warehouse_id = input_use_machinery.nil? ? "" : input_use_machinery.warehouse_id
      material_id = input_use_machinery.nil? ? "" : input_use_machinery.material_id
      material_amount = input_use_machinery.nil? ? 0 : input_use_machinery.material_amount
      uom = input_use_machinery.nil? ? "" : Material.find(input_use_machinery.material_id).unit_of_measurement.name
      
      machineries.push({uuid: m.uuid,
                        name: m.name,
                        selected: selected,
                        warehouse_id: warehouse_id,
                        material_id: material_id,
                        material_amount: material_amount,
                        uom: uom})
    end
    
    render :json => machineries
  end
  
  private
  def machinery_params
    params.require(:machinery).permit(:name, :machinery_type_id, :status, :manufacturer, :model, :registration_number, :year, :note,:source,:planting_project_id, :avatar)
  end
end
