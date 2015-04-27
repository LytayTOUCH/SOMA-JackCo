class PlanZone < ActiveRecord::Base
  include UuidHelper

  belongs_to :plan_production_status

  has_many :plan_areas, foreign_key: :plan_zone_id, dependent: :destroy

  accepts_nested_attributes_for :plan_areas
  
end
