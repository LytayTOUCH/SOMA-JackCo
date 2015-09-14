class LocationPlanPhase < ActiveRecord::Base
  include UuidHelper
  
  has_many :location_plan_stages, foreign_key: :phase_id
end
