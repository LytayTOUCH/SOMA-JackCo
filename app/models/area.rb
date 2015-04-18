class Area < ActiveRecord::Base
  include UuidHelper
  has_many :blocks
  belongs_to :zone
  belongs_to :farm
  
end
