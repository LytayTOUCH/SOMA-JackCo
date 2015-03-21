class Labor < ActiveRecord::Base
  include UuidHelper

  validates :name, length: { maximum: 50 }, presence: true
  validates :position_id, length: { maximum: 36 }, presence: true

  has_many :labors
  has_many :stock_ins

  has_one :user

  belongs_to :labor, foreign_key: :manager_uuid

  belongs_to :position, foreign_key: :position_id

  has_many :input_tasks, foreign_key: :labor_id

  scope :find_by_labor_name, -> name { where("name like ?", "%#{name}%") }

  has_paper_trail
  
end
