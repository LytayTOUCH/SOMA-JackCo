class ProcessPlanCategory < ActiveRecord::Base
  include UuidHelper
  
  has_many :process_plan_materials
end
