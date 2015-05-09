class ProductionPlan < ActiveRecord::Base
  include UuidHelper

  has_many :production_classification_amounts, foreign_key: :production_plan_id

  validates_presence_of :planting_project_id, :message => "Project name can't be blank."
  validates_presence_of :for_year
  
  accepts_nested_attributes_for :production_classification_amounts

end
