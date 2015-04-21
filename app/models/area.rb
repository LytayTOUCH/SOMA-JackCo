class Area < ActiveRecord::Base
  include UuidHelper
  has_many :blocks, foreign_key: :area_id
  has_many :plan_areas, foreign_key: :area_id

  belongs_to :zone
  belongs_to :farm
  
end
