class Maintenance < ActiveRecord::Base
  include UuidHelper

  validates :machinery_uuid, length: { maximum: 36 }, presence: true
  validates :labor_uuid, length: { maximum: 36 }
  validates :engine_hours, numericality: true
  validates :time_spent, numericality: true
  validates :maintenance_type, length: { maximum: 50 }, presence: true

  belongs_to :labor, foreign_key: :labor_uuid
  belongs_to :tractor, foreign_key: :machinery_uuid

  scope :find_limit_10, -> { limit(10) }
end
