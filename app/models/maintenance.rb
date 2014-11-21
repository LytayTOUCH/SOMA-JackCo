class Maintenance < ActiveRecord::Base
  include UuidHelper

  validates :machinery_uuid, length: { maximum: 36 }, presence: true
  validates :labor_uuid, length: { maximum: 36 }
  validates :labor_uuid, numericality: true
  validates :engine_hours, numericality: true
  validates :time_spent, numericality: true
end
