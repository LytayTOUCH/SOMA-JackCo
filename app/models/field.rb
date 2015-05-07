class Field < ActiveRecord::Base
  include UuidHelper
  serialize :lat_long, Array

  validates :name, length: { maximum: 100 }, :presence => { message: "Field name is required" }
  validates :dimension, numericality: true, :presence => { message: "Dimension is required" }
  validates :lat_long, :presence => { message: "Latitude & Longitude are required" }
  
end
