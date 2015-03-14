class Block < ActiveRecord::Base
  include UuidHelper
  belongs_to :farm
  belongs_to :planting_project

  scope :farm_id, -> uuid_f { where(:farm_id => uuid_f) }

  has_paper_trail
  
end
