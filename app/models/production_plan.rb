class ProductionPlan < ActiveRecord::Base
  include UuidHelper

  validates_presence_of :planting_project_id, :message => "Project name can't be blank."
  validates_presence_of :for_year

end
