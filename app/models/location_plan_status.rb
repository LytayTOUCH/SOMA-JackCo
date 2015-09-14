class LocationPlanStatus < ActiveRecord::Base
  include UuidHelper
  
  belongs_to :location_plan_stage, foreign_key: :stage_id
end
