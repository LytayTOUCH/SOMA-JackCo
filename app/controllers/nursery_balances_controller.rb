class NurseryBalancesController < ApplicationController
  def index
    if !params[:warehouse_id].nil?
      @planting_projects = PlantingProject.all
      @unit_id = UnitOfMeasurement.find_by_name('Unit').uuid
    end
  end

  def create
    warehouse_id = params[:warehouse_id]
    unit_id = UnitOfMeasurement.find_by_name('Unit').uuid
    
    params[:distribution_id].each_with_index do |distribution_id, dis_index|
      amount = params[:amount][dis_index]
      
      production_in_wh = ProductionInWarehouse.find_by(warehouse_id: warehouse_id, distribution_id: distribution_id, unit_measure_id: unit_id)
      production_in_wh.update_attributes(amount: amount == "" ? 0 : amount.to_f)
    end
    
    flash[:notice] = "Nursery Balance successfully updated!!!"
    redirect_to nursery_balances_path+"?warehouse_id="+params[:warehouse_id]
  end
end
