class LaborProject < ActiveRecord::Base
  validates :labor_uuid, length: { maximum: 36 }, presence: true
  validates :project_uuid, length: { maximum: 36 }, presence: true
end
