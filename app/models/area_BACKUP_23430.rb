class Area < ActiveRecord::Base
  include UuidHelper
  has_many :blocks, foreign_key: :area_id
<<<<<<< HEAD
  has_many :plan_areas, foreign_key: :area_id

=======
  has_many :planting_projects, through: :blocks
>>>>>>> ff87daca4490800fcf7cd7e2e3b373404bcd9200
  belongs_to :zone
  belongs_to :farm
end
