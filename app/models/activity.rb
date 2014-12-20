class Activity < ActiveRecord::Base
  include UuidHelper

  validates :name, length: { maximum: 100 }, presence: true
end
