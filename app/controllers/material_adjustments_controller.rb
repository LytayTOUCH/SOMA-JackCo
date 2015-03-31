class MaterialAdjustmentsController < ApplicationController
  def index
    @material_adjustments = MaterialAdjustment.joins(:warehouse_material_amount).order("warehouse_material_amounts.warehouse_uuid, material_adjustments.adjust_date desc")
  end
end
