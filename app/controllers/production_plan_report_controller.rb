class ProductionPlanReportController < ApplicationController

  def index
    @project_name = params[:id]
    @year = params[:year]
    
    @production_plan = ProductionPlan.where(planting_project_id: params[:id], for_year: params[:year])
    @planting_name = PlantingProject.where(uuid: params[:id]).first.name unless params[:id].nil?
  end

  def get_production_plan_tree
    production_plan = ProductionPlan.where(planting_project_id: params[:id], for_year: params[:for_year]).last
    render json: production_plan
  end
end
