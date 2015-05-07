class Block < ActiveRecord::Base
  include UuidHelper
  belongs_to :area
  belongs_to :zone
  belongs_to :farm
  belongs_to :planting_project, foreign_key: :planting_project_id
  
  has_many :input_tasks, foreign_key: :block_id
  has_many :output_tasks, foreign_key: :block_id
  has_many :plan_blocks, foreign_key: :block_id

  validates :name, :presence => { message: "Block name is required" }
  validates :surface, :presence => { message: "Surface is required" }
  validates :tree_amount, :presence => { message: "Tree Quantity is required" }
  validates :location_lat_long, :presence => { message: "Location - Lat, long is required" }
  scope :farm_id, -> uuid_f { where(:farm_id => uuid_f) }
  
end
