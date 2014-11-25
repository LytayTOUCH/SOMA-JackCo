class Warehouse < ActiveRecord::Base
  include UuidHelper

  validates :name, length: { maximum: 50 }, presence: true
  validates :labor_uuid, length: {maximum: 36}
  validates :warehouse_type_uuid, length: {maximum: 36}
end
