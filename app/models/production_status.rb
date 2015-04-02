class ProductionStatus < ActiveRecord::Base
  include UuidHelper

  belongs_to :production_stage, foreign_key: :stage_id

  validates :name, length: { maximum: 50 }, presence: true
  validates :stage_id, length: { maximum: 36 }, presence: true

  scope :find_by_production_status_name, -> name { where("name like ?", "%#{name}%") }

end
