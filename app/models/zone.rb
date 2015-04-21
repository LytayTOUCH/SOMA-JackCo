class Zone < ActiveRecord::Base
  include UuidHelper
  belongs_to :farm
  
  has_many :areas, foreign_key: :zone_id
  has_many :blocks, through: :areas
  
end
