class Block < ActiveRecord::Base
  include UuidHelper
  belongs_to :farm
end
