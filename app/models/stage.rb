class Stage < ActiveRecord::Base
  include UuidHelper

  has_one :coconut
  has_one :jack_fruit

  validates :name, length: { maximum: 50 }, presence: true

  scope :find_by_stage_name, -> name { where("name like ?", "%#{name}%") }

end
