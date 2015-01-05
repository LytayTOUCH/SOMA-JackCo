class Field < ActiveRecord::Base
  include UuidHelper
  serialize :lat_long

  validates :name, length: { maximum: 100 }, presence: true
  validates :dimension, numericality: true, presence: true
  validates :lat_long, presence: true
end
