class MaterialAdjustment < ActiveRecord::Base
  include UuidHelper
  
  belongs_to :warehouse_material_amount, foreign_key: :warehouse_material_amount_id
end
