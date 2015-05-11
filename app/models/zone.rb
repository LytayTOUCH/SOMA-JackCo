class Zone < ActiveRecord::Base
  include UuidHelper

  belongs_to :farm, foreign_key: :farm_id
  
  has_many :areas, foreign_key: :zone_id
  has_many :blocks, through: :areas
  has_many :output_tasks, foreign_key: :zone_id
  has_many :plan_zones, foreign_key: :zone_id

end
