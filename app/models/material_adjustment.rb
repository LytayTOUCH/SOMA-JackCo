class MaterialAdjustment < ActiveRecord::Base
  include UuidHelper
  
  belongs_to :warehouse_material_amount, foreign_key: :warehouse_material_amount_id
  
  scope :find_by_warehouse, -> warehouse_uuid { joins(:warehouse_material_amount).where(warehouse_material_amounts: {warehouse_uuid: warehouse_uuid}) }
end
