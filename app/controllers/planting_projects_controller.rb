class PlantingProjectsController < ApplicationController
  before_filter :set_title
  load_and_authorize_resource except: :create

  add_breadcrumb "All Planting Projects", :planting_projects_path

  def index
    @planting_projects = PlantingProject.order('updated_at DESC')
  end

  def new
    @planting_project = PlantingProject.new
  end

  def create
    begin
      @planting_project = PlantingProject.new(planting_project_params)

      if @planting_project.save
        create_log current_user.uuid, "Created New Planting Project", @planting_project
        flash[:notice] = "Planting Project saved successfully"
        redirect_to planting_projects_path
      else
        flash[:notice] = "Planting Project can't be saved"
        render 'new'
      end
    rescue Exception => e
      puts e
    end
  end

  def edit
    @planting_project = PlantingProject.find(params[:id])
    add_breadcrumb @planting_project.name, :edit_planting_project_path
  end

  def update
    begin
      @planting_project = PlantingProject.find(params[:id])

      if @planting_project.update_attributes(planting_project_params)
        create_log current_user.uuid, "Updated Planting Project", @planting_project
        flash[:notice] = "Planting Project updated successfully"
        redirect_to planting_projects_path
      else
        flash[:notice] = "Planting Project can't be updated"
        render 'edit'
      end
    rescue Exception => e
      puts e
    end
  end

  def show
    @planting_project = PlantingProject.find(params[:id])
    @blocks = Block.all.where(farm_id: params[:id])
    @my_farm_latlngs = @planting_project.farms.distinct
  end

  def get_production_data
    @production_data = Production.where(planting_project_id: params[:planting_project_id])
    render :json => @production_data
  end

  def get_machinery_data
    @machinery_datas = Machinery.where("planting_project_id = ? and status = ?", params[:planting_project_id], true).distinct(:name)
    render :json => @machinery_datas
  end

  private
  def set_title
    content_for :title, "Planting Project"
  end
  def planting_project_params
    params.require(:planting_project).permit(:name, :note)
  end

end
