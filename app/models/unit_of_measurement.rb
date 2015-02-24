class UnitOfMeasurement < ActiveRecord::Base
  include UuidHelper

  has_one :material

  validates :name, length: { maximum: 50 }, presence: true
  scope :find_by_unit_of_measurement_name, -> name { where("name like ?", "%#{name}%") }
end
