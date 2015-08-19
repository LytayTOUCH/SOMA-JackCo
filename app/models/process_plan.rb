class ProcessPlan < ActiveRecord::Base
  include UuidHelper
  
  has_many :process_plan_materials
  has_many :process_plan_schedules
  has_many :process_plan_categories, through: :process_plan_materials
end
