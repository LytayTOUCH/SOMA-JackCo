class PlantingProject < ActiveRecord::Base
  include UuidHelper
  
  validates :project_name, length: { maximum: 50 }, presence: true

  scope :find_by_planting_project_name, -> project_name { where("project_name like ?", "%#{project_name}%") }
end
