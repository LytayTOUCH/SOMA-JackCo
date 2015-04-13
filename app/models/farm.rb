class Farm < ActiveRecord::Base
  include UuidHelper
  has_many :blocks
  has_many :planting_projects, through: :blocks
  has_many :plan_farms
  
  validates :name, presence: true
  validates :location, presence: true
  validates :latlong_farm, presence: true
  
end
