class PlanProductionStatus < ActiveRecord::Base
  include UuidHelper

  belongs_to :plan_production_stage, foreign_key: :plan_production_stage_uuid
  belongs_to :plan_farm

  has_many :plan_zones, foreign_key: :plan_production_status_id, dependent: :destroy
  has_many :plan_areas, through: :plan_zones
  
  accepts_nested_attributes_for :plan_zones
  
end
