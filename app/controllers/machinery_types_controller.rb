class MachineryTypesController < ApplicationController
  load_and_authorize_resource except: :create
  add_breadcrumb "All Machinery Types", :machinery_types_path
  
  def index
    @machinery_types = MachineryType.order(created_at: :desc)
  end

  def edit
    @machinery_type = MachineryType.find(params[:id])
    add_breadcrumb @machinery_type.name, :edit_machinery_type_path
  end

  def update
    begin
      @machinery_type = MachineryType.find(params[:id])

      if @machinery_type.update_attributes(machinery_type_params)
        create_log current_user.uuid, "Updated Machinery Type", @machinery_type
        flash[:notice] = "Machinery Type updated successfully"
        redirect_to machinery_types_path
      else
        flash[:notice] = "Machinery Type can't be updated"
        render 'edit'
      end
    rescue Exception => e
      puts e
    end
  end

  def new
    @machinery_type = MachineryType.new
  end

  def create
    begin
      @machinery_type = MachineryType.new(machinery_type_params)

      if @machinery_type.save
        create_log current_user.uuid, "Created New Machinery Type", @machinery_type
        flash[:notice] = "Machinery Type saved successfully"
        redirect_to machinery_types_path
      else
        flash[:notice] = "Machinery Type can't be saved."
        render 'new'
      end
    rescue Exception => e
      puts e
    end
  end
  
  private
  def machinery_type_params
    params.require(:machinery_type).permit(:name, :note)
  end
end
