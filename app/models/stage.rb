class Stage < ActiveRecord::Base
  include UuidHelper

  has_one :coconut, dependent: :destroy
  has_one :jack_fruit, dependent: :destroy

  validates :name, length: { maximum: 50 }, presence: true

  scope :find_by_name, -> name { where("name like ?", "%#{name}%") }

end
