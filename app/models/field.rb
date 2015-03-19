class Field < ActiveRecord::Base
  include UuidHelper
  serialize :lat_long, Array

  validates :name, length: { maximum: 100 }, presence: true
  validates :dimension, numericality: true, presence: true
  validates :lat_long, presence: true

  has_paper_trail
  
end
