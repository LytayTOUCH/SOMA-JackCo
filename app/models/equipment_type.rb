class EquipmentType < ActiveRecord::Base
  include UuidHelper
  
  has_many :equipments
end
