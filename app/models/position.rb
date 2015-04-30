class Position < ActiveRecord::Base
  include UuidHelper

  has_many :labors

  validates :name, length: { maximum: 50 }, :presence => { message: "Position name is required." }

  scope :find_by_position_name, -> name { where("name like ?", "%#{name}%") }

end
