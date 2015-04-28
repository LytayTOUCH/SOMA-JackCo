class ProductionStage < ActiveRecord::Base
  include UuidHelper

  belongs_to :phase, foreign_key: :phase_id

  has_many :production_statuses, foreign_key: :production_stage_id
  has_many :plan_production_stages, foreign_key: :production_stage_id

  validates :name, length: { maximum: 50 }, :presence => { message: "Production stage name is required."}
  validates :phase_id, length: { maximum: 36 }, :presence => { message: "Phase is required."}

  scope :find_by_production_stage_name, -> name { where("name like ?", "%#{name}%") }

end
