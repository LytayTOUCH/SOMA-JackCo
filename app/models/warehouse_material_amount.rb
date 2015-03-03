class WarehouseMaterialAmount < ActiveRecord::Base
	belongs_to :material, foreign_key: :material_uuid
	belongs_to :warehouse, foreign_key: :warehouse_uuid
end
