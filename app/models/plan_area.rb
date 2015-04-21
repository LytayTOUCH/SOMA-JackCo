class PlanArea < ActiveRecord::Base
  include UuidHelper

  belongs_to :plan_production_status
  belongs_to :area

  has_many :plan_blocks, foreign_key: :plan_area_id

  accepts_nested_attributes_for :plan_blocks
  
end
