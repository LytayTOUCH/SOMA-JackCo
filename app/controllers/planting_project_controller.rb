class PlantingProjectController < ApplicationController
  def index
  	begin
      @planting_project = PlantingProject.new

      if params[:planting_project] and params[:planting_project][:project_name] and !params[:planting_project][:project_name].nil?
        @planting_projects = PlantingProject.find_by_name(params[:planting_project][:project_name]).page(params[:page]).per(5)
      else
        @planting_projects = PlantingProject.page(params[:page]).per(5)
      end
    rescue Exception => e
      puts e
    end
  end

end
