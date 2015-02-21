class Labor < ActiveRecord::Base
  include UuidHelper

  validates :name, length: { maximum: 50 }, presence: true
  validates :position_uuid, length: { maximum: 36 }, presence: true

  has_many :labors
  belongs_to :labor, foreign_key: :manager_uuid

  has_one :position, foreign_key: :position_uuid

  scope :find_by_labor_name, -> name { where("name like ?", "%#{name}%") }

end
