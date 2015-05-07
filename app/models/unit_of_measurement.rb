class UnitOfMeasurement < ActiveRecord::Base
  include UuidHelper

  has_many :materials, foreign_key: :unit_measure_uuid

  has_many :productions
  has_many :output_distributions

  validates :name, length: { maximum: 50 }, presence: true
  scope :find_by_unit_of_measurement_name, -> name { where("name like ?", "%#{name}%") }
end
