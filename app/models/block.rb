class Block < ActiveRecord::Base
  include UuidHelper
  belongs_to :farm
  belongs_to :planting_project

  has_many :input_tasks, foreign_key: :block_id

  scope :farm_id, -> uuid_f { where(:farm_id => uuid_f) }

  has_paper_trail
  
end
