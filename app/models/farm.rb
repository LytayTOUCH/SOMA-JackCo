class Farm < ActiveRecord::Base
  include UuidHelper
  has_many :blocks
  validates :name, presence: true
end
