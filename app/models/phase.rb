class Phase < ActiveRecord::Base
  include UuidHelper

  validates :name, length: { maximum: 50 }, :presence => { message: "Phase Name is required." }

  has_many :production_stages
  has_many :plan_phases, foreign_key: :phase_id
  
  scope :find_by_phase_name, -> name { where("name like ?", "%#{name}%") }

end
