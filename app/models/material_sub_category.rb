class MaterialSubCategory < ActiveRecord::Base
  include UuidHelper
  
  belongs_to :material_category, foreign_key: :category_id
end
