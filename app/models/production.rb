class Production < ActiveRecord::Base
  include UuidHelper

  belongs_to :planting_project, foreign_key: :planting_project_id
  belongs_to :unit_of_measurement, foreign_key: :uom_id

  validates :status, length: { maximum: 20 }, presence: true
  validates :planting_project_id, length: {maximum: 36}, presence: true
  validates :uom_id, length: {maximum: 36}, presence: true

end
