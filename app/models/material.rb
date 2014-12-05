class Material < ActiveRecord::Base
  include UuidHelper

  validates :name, length: { maximum: 50 }, presence: true
  validates :quantity, numericality: true
  validates :unit, length: { maximum: 100 }, presence: true
end
