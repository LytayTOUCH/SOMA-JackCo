class PlanProductionStatus < ActiveRecord::Base
  include UuidHelper

  belongs_to :plan_production_stage, foreign_key: :plan_production_stage_uuid

  has_many :plan_areas, foreign_key: :plan_production_status_id

  accepts_nested_attributes_for :plan_areas
  
end
