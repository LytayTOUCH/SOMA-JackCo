class Farm < ActiveRecord::Base
  include UuidHelper

  has_many :zones
  has_many :areas, through: :zones, foreign_key: :zone_id
  has_many :blocks
  has_many :plan_farms

  validates :name, :presence => { message: "Farm name is required" }
  validates :location, :presence => { message: "Location is required" }
  validates :latlong_farm, :presence => { message: "Latitude & longitude are required" }
  
end
