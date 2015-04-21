class PlanProductionStage < ActiveRecord::Base
  include UuidHelper

  belongs_to :plan_phase

  has_many :plan_production_statuses, foreign_key: :plan_production_stage_id, dependent: :destroy

  accepts_nested_attributes_for :plan_production_statuses
  
end
