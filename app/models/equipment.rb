class Equipment < ActiveRecord::Base
  include UuidHelper
  
  validates :name, :planting_project_id, :equipment_type_id, presence: true

  belongs_to :equipment_type, foreign_key: :equipment_type_id

  has_many :input_use_equipments, foreign_key: :input_id
  has_many :input_tasks, through: :input_use_equipments
  
end
