class MachineryTypesController < ApplicationController
  load_and_authorize_resource except: :create
  add_breadcrumb "All Machinery Types", :machinery_types_path
  
  def index
    begin
      @machinery_type = MachineryType.new

      if params[:machinery_type] and params[:machinery_type][:name] and !params[:machinery_type][:name].nil?
        @machinery_types = MachineryType.find_by_name(params[:machinery_type][:name]).page(params[:page]).per(session[:item_per_page])
      else
        @machinery_types = MachineryType.page(params[:page]).per(session[:item_per_page])
      end
    rescue Exception => e
      puts e
    end
  end

  def edit
    @machinery_type = MachineryType.find(params[:id])
    add_breadcrumb @machinery_type.name, :edit_machinery_type_path
  end

  def update
    begin
      @machinery_type = MachineryType.find(params[:id])

      if @machinery_type.update_attributes(machinery_type_params)
        flash[:notice] = "Machinery Type updated successfully"
        redirect_to machinery_types_path
      else
        flash[:notice] = "Machinery Type can't update"
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
        flash[:notice] = "Machinery Type saved successfully"
        redirect_to machinery_types_path
      else
        flash[:notice] = "Machinery Type can't save"
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
