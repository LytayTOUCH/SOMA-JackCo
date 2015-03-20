class ProductionAdjustment < ActiveRecord::Base
  include UuidHelper
  
  belongs_to :warehouse_production_amount, foreign_key: :warehouse_production_amount_id
end
