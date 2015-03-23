class ProductionAdjustment < ActiveRecord::Base
  include UuidHelper
  
  belongs_to :warehouse_production_amount, foreign_key: :warehouse_production_amount_id
  
  scope :find_by_warehouse, -> warehouse_id { joins(:warehouse_production_amount).where(warehouse_production_amounts: {warehouse_id: warehouse_id}) }
end
