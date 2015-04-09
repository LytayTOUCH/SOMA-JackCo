class Equipment < ActiveRecord::Base
  include UuidHelper
  
  validates :name, :planting_project_id, :equipment_type_id, presence: true

  belongs_to :equipment_type, foreign_key: :equipment_type_id
end
