class InputDescPlanSeed < ActiveRecord::Base
  include UuidHelper
  
  belongs_to :input_desc_plan, foreign_key: :input_desc_plan_id
end
