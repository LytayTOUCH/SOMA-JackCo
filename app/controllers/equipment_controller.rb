class EquipmentController < ApplicationController
  load_and_authorize_resource except: :create
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
      flash[:notice] = "Equipment saved successfully"
      redirect_to equipment_index_path
    else
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
      flash[:notice] = "Equipment updated successfully"
      redirect_to equipment_index_path
    else
      flash[:notice] = "Equipment can't update"
      render 'edit'
    end
  end
  
  private
  def equipment_params
    params.require(:equipment).permit(:name, :equipment_type_id, :note, :planting_project_id, :status)
  end 
end
