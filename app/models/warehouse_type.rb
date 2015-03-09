class WarehouseType < ActiveRecord::Base
  include UuidHelper

  has_many :warehouses, foreign_key: :warehouse_type_uuid

  validates :name, length: { maximum: 50 }, presence: true
  scope :find_by_warehouse_type_name, -> name { where("name like ?", "%#{name}%") }
end
