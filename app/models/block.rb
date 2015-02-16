class Block < ActiveRecord::Base
  include UuidHelper
  belongs_to :farm
  belongs_to :planting_project
end
