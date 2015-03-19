class WarehouseMaterialAmount < ActiveRecord::Base
  include UuidHelper
  
	belongs_to :material, foreign_key: :material_uuid
	belongs_to :warehouse, foreign_key: :warehouse_uuid

	scope :find_by_warehouse, -> warehouse_uuid { where("warehouse_uuid = ?", "#{warehouse_uuid}") }
	
	has_paper_trail

end
