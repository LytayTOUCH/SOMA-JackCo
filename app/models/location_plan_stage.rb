class LocationPlanStage < ActiveRecord::Base
  include UuidHelper
  
  belongs_to :location_plan_phase, foreign_key: :phase_id
  has_many :location_plan_statuses, foreign_key: :stage_id
end
