class PlantingProject < ActiveRecord::Base
  include UuidHelper
  
  has_many :blocks, foreign_key: :planting_project_id
  has_many :farms, through: :blocks
  has_many :areas, through: :blocks
  has_many :zones, through: :areas
  has_many :input_tasks, through: :blocks
  has_many :productions
  has_many :production_stages
  has_many :output_tasks, foreign_key: :planting_project_id
  has_many :warehouse_production_amounts, through: :productions

  validates :name, length: { maximum: 50 }, :presence => { message: "Planting Project Name is required." }

  scope :find_by_project_name, -> name { where("name like ?", "%#{name}%") }

end
