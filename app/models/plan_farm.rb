class PlanFarm < ActiveRecord::Base
  include UuidHelper

  belongs_to :farm, foreign_key: :farm_id

  has_many :plan_phases, foreign_key: :plan_farm_id, dependent: :destroy
  
  validates :farm_id, :for_year, presence: true

  accepts_nested_attributes_for :plan_phases
end
