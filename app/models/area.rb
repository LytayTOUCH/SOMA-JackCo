class Area < ActiveRecord::Base
  include UuidHelper
  
  belongs_to :zone
  belongs_to :farm

  has_many :blocks, foreign_key: :area_id
  has_many :plan_areas, foreign_key: :area_id

  has_many :planting_projects, through: :blocks

end