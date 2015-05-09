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

  def get_production_classification
    @production_plans = ProductionPlan.new
    @production_plans.planting_project_id = params[:pid]
    @production_plans.for_year = params[:y]
    
    @production_classifications = ProductionClassification.where(planting_project_id: params[:pid])
    @production_classifications.each do |production_classification|
      @amount = @production_plans.production_classification_amounts.build
      @amount.production_classification_id = production_classification.uuid
    end

    render partial: 'form'
  end

  private
  def production_plans_params
    params.require(:production_plan).permit(:id, :planting_project_id, :for_year, 
      :jan, :feb, :mar, :apr, :may, :jun, :jul, :aug, :sep, :oct, :nov, :dec, 
      production_classification_amounts_attributes: [:id, :production_plan_id, :production_classification_id, :amount])
  end  
end
