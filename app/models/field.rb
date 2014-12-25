class Field < ActiveRecord::Base
  include UuidHelper
  
  serialize :lat_long
end
