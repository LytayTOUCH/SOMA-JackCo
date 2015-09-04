class InputDescPlan < ActiveRecord::Base
  include UuidHelper
  
  has_many :input_desc_plan_seeds, foreign_key: :input_desc_plan_id
  has_many :input_desc_plan_materials, foreign_key: :input_desc_plan_id
  has_many :material_categories, through: :input_desc_plan_materials
end
