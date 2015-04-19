class PlanArea < ActiveRecord::Base
  belongs_to :plan_production_status
  belongs_to :area
  
  has_many :plan_blocks, foreign_key: :plan_area_id

end
