class ProductionAdjustmentsController < ApplicationController
  def index
    @production_adjustments = ProductionAdjustment.joins(:warehouse_production_amount).order("warehouse_production_amounts.warehouse_id, production_adjustments.adjust_date desc")
  end
end
