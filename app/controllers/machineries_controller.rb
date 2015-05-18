class MachineriesController < ApplicationController
  load_and_authorize_resource except: :create
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
      puts "================== +++++ ===================="
      puts params[:machinery][:status]
      puts "================== +++++ ===================="

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
    @material_type = MaterialCategory.find_by_name("Indirect Materials")
    @materials = Material.where(material_cate_uuid: @material_type.uuid)
    render :json => {warehouse: @project_warehouses, machinery_name: @machinery_name, material: @materials}
  end
  
  private
  def machinery_params
    params.require(:machinery).permit(:name, :machinery_type_id, :status, :manufacturer, :model, :registration_number, :year, :note,:source,:planting_project_id, :avatar)
  end
end
