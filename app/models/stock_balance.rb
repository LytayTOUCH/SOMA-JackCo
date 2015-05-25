class StockBalance < ActiveRecord::Base
  include UuidHelper
  
  belongs_to :material_category, foreign_key: :material_category_id
  belongs_to :material, foreign_key: :material_id
end
