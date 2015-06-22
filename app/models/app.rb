class App < ActiveRecord::Base
  include UuidHelper
  
  validates :name, :presence => { message: "Application Name is required." }
  validates :app_type, :presence => { message: "Application Type is required." }
  validates :planting_project_id, :presence => { message: "Planting Project is required." }
  
  belongs_to :planting_project, foreign_key: :planting_project_id
end
