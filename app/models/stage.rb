class Stage < ActiveRecord::Base
  include UuidHelper

  # has_one :coconut

  validates :name, length: { maximum: 50 }, presence: true
  validates :period, length: { maximum: 50 }, presence: true

end
