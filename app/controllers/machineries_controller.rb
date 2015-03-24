class MachineriesController < ApplicationController
  load_and_authorize_resource except: :create
  add_breadcrumb "All Machineries", :machineries_path
  
  def index
    begin
      @machinery = Machinery.new
      
      if params[:machinery] and params[:machinery][:name] and !params[:machinery][:name].nil?
        @machinery.name = params[:machinery][:name]
        @machineries = Machinery.find_by_name(params[:machinery][:name]).page(params[:page]).per(session[:item_per_page])
      else
        @machineries = Machinery.page(params[:page]).per(session[:item_per_page])
      end
    rescue Exception => e
      puts e
    end
  end
  
  def new
    begin
      @machinery = Machinery.new
      @machinery_types = MachineryType.all
    rescue Exception => e
      puts e
    end
  end
  
  def create
    begin
      @machinery = Machinery.new(machinery_params)

      if @machinery.save!
        flash[:notice] = "Machinery saved successfully"
        redirect_to machineries_path
      else
        flash[:notice] = "Machinery can't save"
        render 'new'
      end
    rescue Exception => e
      puts e
    end
  end
  
  def edit
    begin
      @machinery = Machinery.find(params[:id])
      @machinery_types = MachineryType.all
      add_breadcrumb @machinery.name, :edit_machinery_path
    rescue Exception => e
      puts e
    end
  end
  
  def update
    begin
      @machinery = Machinery.find(params[:id])

      if @machinery.update_attributes(machinery_params)
        flash[:notice] = "Machinery updated successfully"
        redirect_to machineries_path
      else
        flash[:notice] = "Machinery can't update"
        render 'edit'
      end
    rescue Exception => e
      puts e
    end
  end
  
  private
  def machinery_params
    params.require(:machinery).permit(:name, :machinery_type_id, :status, :manufacturer, :model, :registration_number, :year, :note)
  end
end
