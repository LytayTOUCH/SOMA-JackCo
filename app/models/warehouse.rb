class Warehouse < ActiveRecord::Base
  include UuidHelper
  belongs_to :warehouse_type, foreign_key: :warehouse_type_uuid

  validates :name, length: { maximum: 50 }, presence: true
  validates :labor_uuid, length: {maximum: 36}
  validates :warehouse_type_uuid, length: {maximum: 36}
end