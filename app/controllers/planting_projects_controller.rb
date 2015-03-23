class PlantingProjectsController < ApplicationController
  before_filter :set_title
  load_and_authorize_resource except: :create

  add_breadcrumb "All Planting Projects", :planting_projects_path

  def index
  	begin
      @planting_project = PlantingProject.new

      if params[:planting_project] and params[:planting_project][:name] and !params[:planting_project][:name].nil?
        @planting_projects = PlantingProject.find_by_project_name(params[:planting_project][:name]).page(params[:page]).per(session[:item_per_page])
      else
        @planting_projects = PlantingProject.page(params[:page]).order('updated_at DESC').per(session[:item_per_page])
      end
    rescue Exception => e
      puts e
    end
  end

  def new
    @planting_project = PlantingProject.new
  end

  def create
    begin
      @planting_project = PlantingProject.new(planting_project_params)

      if @planting_project.save
        flash[:notice] = "Planting Project saved successfully"
        redirect_to planting_projects_path
      else
        flash[:notice] = "Planting Project can't save"
        # redirect_to :back
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
        flash[:notice] = "Planting Project updated successfully"
        redirect_to planting_projects_path
      else
        flash[:notice] = "Planting Project can't update"
        # redirect_to :back
        render 'edit'
      end
    rescue Exception => e
      puts e
    end
  end

  def show
    @planting_project = PlantingProject.find(params[:id])
    @my_farm_latlngs = @planting_project.farms.distinct
  end

  private
  def set_title
    content_for :title, "Planting Project"
  end
  def planting_project_params
    params.require(:planting_project).permit(:name, :note)
  end

end
