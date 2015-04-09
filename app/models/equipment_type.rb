class EquipmentType < ActiveRecord::Base
  include UuidHelper
  
  validates :name, presence: true
  
  has_many :equipments
end
