class WarehouseMaterialAmount < ActiveRecord::Base
  include UuidHelper
  
	belongs_to :material, foreign_key: :material_uuid
	belongs_to :warehouse, foreign_key: :warehouse_uuid
end
