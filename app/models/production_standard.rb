class ProductionStandard < ActiveRecord::Base
  include UuidHelper

  belongs_to :planting_project

  validates_presence_of :for_year, :message => "Year can not be blank."
  validates_presence_of :planting_project_id, :message => "Project name can not be blank."
end
