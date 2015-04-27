class PlanPhase < ActiveRecord::Base
  include UuidHelper

  belongs_to :plan_farm

  has_many :plan_production_stages, foreign_key: :plan_phase_id, dependent: :destroy
  
  validates_presence_of :phase_id, :message => "Phase can not empty."
  
  accepts_nested_attributes_for :plan_production_stages

end
