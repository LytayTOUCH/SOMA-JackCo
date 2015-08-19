class ProcessPlanSchedule < ActiveRecord::Base
  include UuidHelper
  
  belongs_to :process_plan, foreign_key: :process_plan_id
end
