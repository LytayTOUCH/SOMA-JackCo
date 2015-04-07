class EquipmentTypesController < ApplicationController
	load_and_authorize_resource except: :create
  add_breadcrumb "All Equipment Types", :equipment_types_path
  
  def index
    @equipment_types = EquipmentType.order(created_at: :desc)
  end

  def edit
    @equipment_type = EquipmentType.find(params[:id])
    add_breadcrumb @equipment_type.name, :edit_equipment_type_path
  end

  def update
    begin
      @equipment_type = EquipmentType.find(params[:id])

      if @equipment_type.update_attributes(equipment_type_params)
        flash[:notice] = "Equipment Type updated successfully"
        redirect_to equipment_types_path
      else
        flash[:notice] = "Equipment Type can't update"
        render 'edit'
      end
    rescue Exception => e
      puts e
    end
  end

  def new
    @equipment_type = EquipmentType.new
  end

  def create
    begin
      @equipment_type = EquipmentType.new(equipment_type_params)

      if @equipment_type.save
        flash[:notice] = "Equipment Type saved successfully"
        redirect_to equipment_types_path
      else
        flash[:notice] = "Equipment Type can't save"
        render 'new'
      end
    rescue Exception => e
      puts e
    end
  end
  
  private
  def equipment_type_params
    params.require(:equipment_type).permit(:name, :note)
  end
end
