class PlantingProject < ActiveRecord::Base
  include UuidHelper
  has_paper_trail
  
  has_many :blocks
  has_many :farms, through: :blocks
  has_many :productions
  validates :name, length: { maximum: 50 }, presence: true

  has_many :production_stages

  scope :find_by_project_name, -> name { where("name like ?", "%#{name}%") }

  has_paper_trail

end
