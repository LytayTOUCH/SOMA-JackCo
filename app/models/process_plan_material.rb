class ProcessPlanMaterial < ActiveRecord::Base
  include UuidHelper
  
  belongs_to :process_plan, foreign_key: :process_plan_id
  belongs_to :process_plan_category, foreign_key: :process_plan_category_id
end
