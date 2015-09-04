class InputDescPlanMaterial < ActiveRecord::Base
  include UuidHelper
  
  belongs_to :input_desc_plan, foreign_key: :input_desc_plan_id
  belongs_to :material_category, foreign_key: :category_id
end
