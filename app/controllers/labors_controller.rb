class LaborsController < ApplicationController
  load_and_authorize_resource except: :create
  
  add_breadcrumb "All Labors", :labors_path

  def index
    begin
      @labor = Labor.new
      
      if params[:labor] and params[:labor][:name] and !params[:labor][:name].nil?
        @labors = LaborDecorator.new(Labor.find_by_labor_name(params[:labor][:name]).page(params[:page]).per(session[:item_per_page]))
      else
        @labors = LaborDecorator.new(Labor.page(params[:page]).per(session[:item_per_page]))
      end
    rescue Exception => e
      puts e
    end
  end

  def new
    begin
      @labor = Labor.new
      
      @position = Position.find_by_name("Manager")
      
      @selected_labors = @position.labors
        
      @positions = Position.all

      @projects = Project.all
      respond_to do |format|
        format.html
        format.json { render json: @projects }
      end
    rescue Exception => e
      puts e
    end
  end

  def create
    begin
      @labor = Labor.new(labor_params)

      if @labor.save!
        flash[:notice] = "Labor saved successfully"
        redirect_to labors_path
      else
        flash[:notice] = "Labor can't save"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  def edit
    @labor = Labor.find(params[:id])
    @labors = Labor.all
    @positions = Position.all
    @position = Position.find_by_name("Manager")
    @selected_labors = @position.labors
    add_breadcrumb @labor.name, :edit_labor_path
  end

  def update
    begin
      @labor = Labor.find(params[:id])

      if @labor.update_attributes!(labor_params)
        flash[:notice] = "Labor updated successfully"
        redirect_to labors_path
      else
        flash[:notice] = "Labor can't be updated"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  def projects
    begin
      projects = Project.where("name like ?", "%#{params[:q]}%")

      respond_to do |format|
        format.html
        format.json { render json: projects.map { |project| { id: project.id, text: project.name }}}
      end
    rescue Exception => e
      puts e
    end
  end

  def labors
    begin
      labors = Labor.where("name like ?", "%#{params[:q]}%")

      respond_to do |format|
        format.html
        format.json { render json: labors.map { |labor| { id: labor.id, text: labor.name }}}
      end
    rescue Exception => e
      puts e
    end
  end

  private
  def labor_params
    params.require(:labor).permit(:name, :position_id, :gender, :phone, :email, :address, :manager_uuid, :note, :active)
  end
end
