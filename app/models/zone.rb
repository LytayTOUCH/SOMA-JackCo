class Zone < ActiveRecord::Base
  include UuidHelper
  has_many :areas, foreign_key: :zone_id
  has_many :blocks, through: :areas
  belongs_to :farm, foreign_key: :farm_id

end
