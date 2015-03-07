class Warehouse < ActiveRecord::Base
  include UuidHelper
  
  belongs_to :warehouse_type, foreign_key: :warehouse_type_uuid

  has_many :warehouse_material_amounts
  has_many :materials, through: :warehouse_material_amounts

  validates :name, length: { maximum: 50 }, presence: true

  validates :warehouse_type_uuid, length: {maximum: 36}, presence: true

  scope :find_by_warehouse_name, -> name { where("name like ?", "%#{name}%") }
end
