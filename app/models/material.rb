class Material < ActiveRecord::Base
  include UuidHelper

  belongs_to :material_category, foreign_key: :material_cate_uuid
  belongs_to :unit_of_measurement, foreign_key: :unit_measure_uuid

  has_many :warehouse_material_amounts, foreign_key: :material_uuid
  has_many :warehouses, through: :warehouse_material_amounts 
  has_many :stock_ins

  validates :name, length: { maximum: 50 }, presence: true
  validates :material_cate_uuid, length: { maximum: 36 }, presence: true
  validates :unit_measure_uuid, length: { maximum: 36 }, presence: true
  # validates :quantity, numericality: true
  # validates :unit, length: { maximum: 100 }, presence: true

  # belongs_to :supplier, foreign_key: :supplier_uuid

  scope :find_by_material_name, -> name { where("name like ?", "%#{name}%") }

  has_paper_trail

end
