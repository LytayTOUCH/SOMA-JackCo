class PlanProductionStage < ActiveRecord::Base
  include UuidHelper

  belongs_to :plan_phase
  belongs_to :plan_farm
  
  has_many :plan_production_statuses, foreign_key: :plan_production_stage_id, dependent: :destroy
  
  validates_presence_of :production_stage_id, :message => "Production stage can not empty."

  accepts_nested_attributes_for :plan_production_statuses
  
end
