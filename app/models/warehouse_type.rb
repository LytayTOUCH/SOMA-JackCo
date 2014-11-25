class WarehouseType < ActiveRecord::Base
  include UuidHelper

  validates :name, length: { maximum: 50 }, presence: true
end
