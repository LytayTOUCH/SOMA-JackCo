class PlantingProject < ActiveRecord::Base
  include UuidHelper
  has_many :blocks
  has_many :farms, through: :blocks
  validates :project_name, length: { maximum: 50 }, presence: true

  scope :find_by_name, -> project_name { where("project_name like ?", "%#{project_name}%") }
end
