class Block < ActiveRecord::Base
  include UuidHelper
  belongs_to :farm
  belongs_to :planting_project
  validates :name, presence: true
  validates :surface, presence: true
  validates :tree_amount, presence: true
  validates :shape_lat_long, presence: true
  scope :farm_id, -> uuid_f { where(:farm_id => uuid_f) }
end
