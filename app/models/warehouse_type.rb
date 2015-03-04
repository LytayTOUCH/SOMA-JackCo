class WarehouseType < ActiveRecord::Base
  include UuidHelper

  has_many :warehouses
  validates :name, length: { maximum: 50 }, presence: true
  scope :find_by_warehouse_type_name, -> name { where("name like ?", "%#{name}%") }
end