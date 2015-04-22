class Farm < ActiveRecord::Base
  include UuidHelper
  
  has_many :zones, foreign_key: :farm_id
  has_many :areas, through: :zones, foreign_key: :zone_id
  has_many :blocks, through: :areas, foreign_key: :area_id
  
  has_many :planting_projects, through: :blocks
  has_many :plan_farms
  validates :name, presence: true
  validates :location, presence: true
  validates :latlong_farm, presence: true
  
end
