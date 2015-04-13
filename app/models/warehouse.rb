class Warehouse < ActiveRecord::Base
  include UuidHelper
  
  validates :name, length: { maximum: 50 }, presence: true
  validates :warehouse_type_uuid, length: {maximum: 36}, presence: true
  validates :address, presence: true
  
  belongs_to :warehouse_type, foreign_key: :warehouse_type_uuid

  has_many :warehouse_material_amounts, foreign_key: :warehouse_uuid
  has_many :materials, through: :warehouse_material_amounts
  
  has_many :material_categories, through: :materials
  has_many :planting_projects, through: :productions

  has_many :warehouse_production_amounts, foreign_key: :warehouse_id
  has_many :productions, through: :warehouse_production_amounts
  
  has_many :machineries

  has_many :stock_ins

  has_many :input_tasks, foreign_key: :warehouse_id

  scope :find_by_warehouse_name, -> name { where("name like ?", "%#{name}%") }

end
