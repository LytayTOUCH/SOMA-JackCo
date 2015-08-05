class PlanProcessesController < ApplicationController
  def index
    if !params[:filter].nil? && params[:filter][:year]!=""
      @year = params[:filter][:year]
    end
  end
  
  def new
    @year = params[:year]
    @planting_project_id = params[:planting_project_id]
  end
  
  def create
    
  end
end
