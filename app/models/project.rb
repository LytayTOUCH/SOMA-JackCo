class Project < ActiveRecord::Base
  include UuidHelper

  validates :name, length: { maximum: 50 }, :presence => { message: "Project is required." }
  
  has_many :labor_projects, dependent: :destroy
  has_many :labors, through: :labor_projects

end
