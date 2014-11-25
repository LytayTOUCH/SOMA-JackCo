class Labor < ActiveRecord::Base
  include UuidHelper

  validates :name, length: { maximum: 50 }, presence: true
  validates :position_uuid, length: { maximum: 36 }, presence: true
  validates :labor_project_uuid, length: { maximum: 36 }
  validates :labor_subordinate, length: { maximum: 36 }

  has_one :maintenance
end
