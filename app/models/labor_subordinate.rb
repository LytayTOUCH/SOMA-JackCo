class LaborSubordinate < ActiveRecord::Base
  validates :labor_uuid, length: { maximum: 36 }, presence: true
  validates :subordinate_uuid, length: { maximum: 36 }, presence: true
end
