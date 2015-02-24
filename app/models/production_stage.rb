class ProductionStage < ActiveRecord::Base
  include UuidHelper

  belongs_to :planting_project, foreign_key: :planting_project_id
  belongs_to :phase, foreign_key: :phase_id

  validates :name, length: { maximum: 50 }, presence: true

  scope :find_by_production_stage_name, -> name { where("name like ?", "%#{name}%") }
end
