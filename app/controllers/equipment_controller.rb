class EquipmentController < ApplicationController
  load_and_authorize_resource except: :create
  add_breadcrumb "All Equipments", :equipment_index_path
  
  def index
    @equipment = Equipment.order(created_at: :desc)
    @planting_projects = PlantingProject.all
  end
  
  def new
    begin
      @equipment = Equipment.new
      @equipment_types = EquipmentType.where(status: true)
      @planting_projects = PlantingProject.all
    rescue Exception => e
      puts e
    end
  end
  
  def create
    begin
      @equipment = Equipment.new(equipment_params)

      if @equipment.save!
        flash[:notice] = "Equipment saved successfully"
        redirect_to equipment_index_path
      else
        flash[:notice] = "Equipment can't save"
        render 'new'
      end
    rescue Exception => e
      puts e
    end
  end
  
  def edit
    begin
      @equipment = Equipment.find(params[:id])
      @planting_projects = PlantingProject.all
      add_breadcrumb @equipment.name, :edit_equipment_path
    rescue Exception => e
      puts e
    end
  end
  
  def update
    begin
      @equipment = Equipment.find(params[:id])

      if @equipment.update_attributes(equipment_params)
        flash[:notice] = "Equipment updated successfully"
        redirect_to equipment_index_path
      else
        flash[:notice] = "Equipment can't update"
        render 'edit'
      end
    rescue Exception => e
      puts e
    end
  end
  
  private
  def equipment_params
    params.require(:equipment).permit(:name, :equipment_type_id, :note, :planting_project_id, :status)
  end 
end
