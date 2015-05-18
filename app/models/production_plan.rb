class ProductionPlan < ActiveRecord::Base
  include UuidHelper

  has_many :production_classification_amounts, foreign_key: :production_plan_id

  validates_presence_of :planting_project_id, :message => "Project name can't be blank."
  validates_presence_of :for_year, :message => "Year can't be blank."
  validates_uniqueness_of :planting_project_id, :scope => :for_year, :message => "This project name and year are already existed."

  accepts_nested_attributes_for :production_classification_amounts

end
