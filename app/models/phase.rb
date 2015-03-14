class Phase < ActiveRecord::Base
  include UuidHelper

  validates :name, length: { maximum: 50 }, presence: true

  has_many :production_stages

  scope :find_by_phase_name, -> name { where("name like ?", "%#{name}%") }

  has_paper_trail

end
