class PlanPhase < ActiveRecord::Base
  include UuidHelper

  belongs_to :plan_farm, foreign_key: :plan_phase_id

  has_many :plan_production_stages, foreign_key: :plan_phase_id, dependent: :destroy

  accepts_nested_attributes_for :plan_production_stages

end
