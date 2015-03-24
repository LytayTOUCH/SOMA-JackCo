class WarehouseMachineryAmount < ActiveRecord::Base
  include UuidHelper
  
  belongs_to :machinery, foreign_key: :machinery_id
  belongs_to :warehouse, foreign_key: :warehouse_id
  
  has_paper_trail
end
