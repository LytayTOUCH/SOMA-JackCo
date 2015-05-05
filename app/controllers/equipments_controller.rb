class EquipmentsController < ApplicationController
  load_and_authorize_resource except: :create
  add_breadcrumb "All Equipments", :equipments_path
  
  def index
    @equipment = Equipment.order(created_at: :desc)
  end
  
  def new
    begin
      @equipment = Equipment.new
      @equipment_types = EquipmentType.all
    rescue Exception => e
      puts e
    end
  end
  
  def create
    begin
      @equipment = Equipment.new(equipment_params)

      if @equipment.save!
        create_log current_user.uuid, "Created New Equipment", @equipment
        flash[:notice] = "Equipment saved successfully"
        redirect_to equipments_path
      else
        flash[:notice] = "Equipment can't be saved"
        render 'new'
      end
    rescue Exception => e
      puts e
    end
  end
  
  def edit
    begin
      @equipment = Equipment.find(params[:id])
      @equipment_types = EquipmentType.all
      add_breadcrumb @equipment.name, :edit_equipment_path
    rescue Exception => e
      puts e
    end
  end
  
  def update
    begin
      @equipment = Equipment.find(params[:id])

      if @equipment.update_attributes(equipment_params)
        create_log current_user.uuid, "Updated Equipment", @equipment
        flash[:notice] = "Equipment updated successfully"
        redirect_to equipments_path
      else
        flash[:notice] = "Equipment can't be updated"
        render 'edit'
      end
    rescue Exception => e
      puts e
    end
  end
  
  private
  def equipment_params
    params.require(:equipment).permit(:name, :equipment_type_id, :note, :status, :planting_project_id)
  end
end
