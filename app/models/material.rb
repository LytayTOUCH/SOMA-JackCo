class Material < ActiveRecord::Base
  include UuidHelper

  belongs_to :material_category, foreign_key: :material_cate_uuid
  belongs_to :unit_of_measurement, foreign_key: :unit_measure_uuid

  validates :name, length: { maximum: 50 }, presence: true
  validates :material_cate_uuid, length: { maximum: 36 }, presence: true
  validates :unit_measure_uuid, length: { maximum: 36 }, presence: true
  # validates :quantity, numericality: true
  # validates :unit, length: { maximum: 100 }, presence: true

  # belongs_to :supplier, foreign_key: :supplier_uuid

  scope :find_by_name, -> name { where("name like ?", "%#{name}%") }
end
