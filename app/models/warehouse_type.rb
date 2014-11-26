class WarehouseType < ActiveRecord::Base
  include UuidHelper
  has_one :warehouse
  
  validates :name, length: { maximum: 50 }, presence: true
end