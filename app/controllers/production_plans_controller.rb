class ProductionPlansController < ApplicationController
  def index
    @production_plans = ProductionPlan.all
  end

  def new
    @production_plans = ProductionPlan.new
  end

  def create
    @production_plans = ProductionPlan.new(production_plans_params)

    if @production_plans.save
      redirect_to production_plans_path, :notice => "Production plan saved successfully"
    else
      render "new"
    end
  end

  def edit
    @production_plans = ProductionPlan.find(params[:id])
  end

  def update
    @production_plans = ProductionPlan.find(params[:id])

    if @production_plans.update_attributes(production_plans_params)
      redirect_to production_plans_path, :notice => "Production plan updated successfully"
    else
      render 'edit', :notice => "Production plan can't update"
    end
  end
  
  private
  def production_plans_params
    params.require(:production_plan).permit(:id, :planting_project_id, :for_year, 
      :jan, :feb, :mar, :apr, :may, :jun, :jul, :aug, :sep, :oct, :nov, :dec)
  end  
end
