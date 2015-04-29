class Area < ActiveRecord::Base
  include UuidHelper
  has_many :blocks, foreign_key: :area_id
  has_many :planting_projects, through: :blocks
  belongs_to :zone
  belongs_to :farm

  validates :name, presence: true
end
