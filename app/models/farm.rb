class Farm < ActiveRecord::Base
  include UuidHelper
  has_many :blocks
  has_many :planting_projects, through: :blocks
  validates :name, presence: true
end
