class EquipmentController < ApplicationController
  load_and_authorize_resource except: [:create, :get_equipment_data, :get_output_equipment_data, :get_input_equipment_data]
  add_breadcrumb "All Equipments", :equipment_index_path
  
  def index
    @equipment = Equipment.order(created_at: :desc)
  end
  
  def new
    @equipment = Equipment.new
  end
  
  def create
    @equipment = Equipment.new(equipment_params)

    if @equipment.save
      create_log current_user.uuid, "Created New Equipment", @equipment
      flash[:notice] = "Equipment saved successfully"
      redirect_to equipment_index_path
    else
      flash[:notice] = "Equipment can't be saved"
      render "new"
    end
  end
  
  def edit
    @equipment = Equipment.find(params[:id])
    add_breadcrumb @equipment.name, :edit_equipment_path
  end
  
  def update
    @equipment = Equipment.find(params[:id])

    if @equipment.update_attributes(equipment_params)
      if params[:equipment][:status] == "false"
          create_log current_user.uuid, "Deactivated Equipment", @equipment
      elsif params[:equipment][:status] == "true"
        create_log current_user.uuid, "Activated Equipment", @equipment
      end

      if params[:equipment][:status] == "1" or params[:equipment][:status] == "0"
        create_log current_user.uuid, "Updated Equipment", @equipment  
      end 
      flash[:notice] = "Equipment updated successfully"
      redirect_to equipment_index_path
    else
      flash[:notice] = "Equipment can't be updated"
      render 'edit'
    end
  end

  def get_equipment_data
    @equipment_datas = Equipment.where("planting_project_id = ? and status = ?", params[:planting_project_id], true).distinct(:name)
    render :json => @equipment_datas
  end
  
  def get_output_equipment_data
    equipments = Array.new
    Equipment.where("planting_project_id = ? and status = ?", params[:planting_project_id], true).each do |e|
      selected = OutputUseEquipment.find_by(output_id: params[:output_task_id], equipment_id: e.uuid).nil? ? false : true
      equipments.push({uuid: e.uuid, name: e.name, selected: selected})
    end
    
    render :json => equipments
  end
  
  def get_input_equipment_data
    equipments = Array.new
    Equipment.where("planting_project_id = ? and status = ?", params[:planting_project_id], true).each do |e|
      selected = InputUseEquipment.find_by(input_id: params[:input_task_id], equipment_id: e.uuid).nil? ? false : true
      equipments.push({uuid: e.uuid, name: e.name, selected: selected})
    end
    
    render :json => equipments
  end
  
  private
  def equipment_params
    params.require(:equipment).permit(:name, :equipment_type_id, :note, :planting_project_id, :status)
  end 
end
