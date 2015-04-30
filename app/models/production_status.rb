class ProductionStatus < ActiveRecord::Base
  include UuidHelper

  belongs_to :production_stage, foreign_key: :stage_id

  has_many :plan_production_statuses, foreign_key: :stage_id

  validates :name, length: { maximum: 50 }, :presence => { message: "Production Status name is required." }
  validates :stage_id, length: { maximum: 36 }, :presence => { message: "Stage is required." }

  scope :find_by_production_status_name, -> name { where("name like ?", "%#{name}%") }

end
