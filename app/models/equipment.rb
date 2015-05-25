class Equipment < ActiveRecord::Base
  include UuidHelper
  
  validates :name, :presence => { message: "Equipment name is required." }
  validates :planting_project_id, :presence => { message: "Planting Project is required." }
  validates :equipment_type_id, :presence => { message: "Equipment Type is required." }

  belongs_to :planting_project, foreign_key: :planting_project_id
  belongs_to :equipment_type, foreign_key: :equipment_type_id

  has_many :input_use_equipments, foreign_key: :input_id
  has_many :input_tasks, through: :input_use_equipments
  
  has_many :output_use_equipments, foreign_key: :output_id
  has_many :output_tasks, through: :output_use_equipments
end
