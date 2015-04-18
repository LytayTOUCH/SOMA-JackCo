class Zone < ActiveRecord::Base
  include UuidHelper
  belongs_to :farm
  
  has_many :areas
  has_many :blocks, through: :areas
  
end
