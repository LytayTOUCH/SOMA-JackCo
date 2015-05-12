class EquipmentType < ActiveRecord::Base
  include UuidHelper
  
  validates :name, :presence => { message: "Equipment Type name is required." }
  
  has_many :equipments
end
