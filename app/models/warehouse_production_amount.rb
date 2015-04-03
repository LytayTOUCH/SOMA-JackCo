class WarehouseProductionAmount < ActiveRecord::Base
  include UuidHelper
  
  belongs_to :warehouse, foreign_key: :warehouse_id
  belongs_to :production, foreign_key: :production_id
  
  has_many :production_adjustments
  has_many :output_tasks
  
  scope :find_by_warehouse, -> warehouse_id { where("warehouse_id = ?", "#{warehouse_id}") }

end
