class ProductionStandardsController < ApplicationController

def index
    @production_standards = ProductionStandard.all
  end

  def new
    @production_standards = ProductionStandard.new
  end

  def create
    @production_standards = ProductionStandard.new(production_standards_params)

    if @production_standards.save
      create_log current_user.uuid, "Created New Production Standard", @production_standards
      redirect_to production_standards_path, :notice => "Production plan saved successfully"
    else
      render "new"
    end
  end

  def edit
    @production_standards = ProductionStandard.find(params[:id])
  end

  def update
    @production_standards = ProductionStandard.find(params[:id])

    if @production_standards.update_attributes(production_standards_params)
      create_log current_user.uuid, "Updated Production Standard", @production_standards
      redirect_to production_standards_path, :notice => "Production plan updated successfully"
    else
      render 'edit', :notice => "Production plan can't update"
    end
  end

  private
  def production_standards_params
    params.require(:production_standard).permit(:id, :planting_project_id, :for_year, 
      :jan, :feb, :mar, :apr, :may, :jun, :jul, :aug, :sep, :oct, :nov, :dec)
  end  
end
