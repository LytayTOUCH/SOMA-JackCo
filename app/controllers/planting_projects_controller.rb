class PlantingProjectsController < ApplicationController
  before_filter :set_title
  # load_and_authorize_resource except: :create

  def index
  	begin
      @planting_project = PlantingProject.new

      if params[:planting_project] and params[:planting_project][:project_name] and !params[:planting_project][:project_name].nil?
        @planting_projects = PlantingProject.find_by_name(params[:planting_project][:project_name]).page(params[:page]).per(5)
      else
        @planting_projects = PlantingProject.page(params[:page]).order('updated_at DESC').per(5)
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

      if @planting_project.save!
        flash[:notice] = "Planting Project saved successfully"
        redirect_to planting_projects_path
      else
        flash[:notice] = "Planting Project can't save"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  def edit
    @planting_project = PlantingProject.find(params[:id])
  end

  def update
    begin
      @planting_project = PlantingProject.find(params[:id])

      if @planting_project.update_attributes!(planting_project_params)
        flash[:notice] = "Planting Project updated successfully"
        redirect_to planting_projects_path
      else
        flash[:notice] = "Planting Project can't update"
        redirect_to :back
      end
    rescue Exception => e
      puts e
    end
  end

  private
  def set_title
    content_for :title, "Planting Project"
  end
  def planting_project_params
    params.require(:planting_project).permit(:project_name, :note)
  end

end
