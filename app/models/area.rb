class Area < ActiveRecord::Base
  include UuidHelper
  has_many :blocks, foreign_key: :area_id
  has_many :plan_areas, foreign_key: :area_id
  has_many :planting_projects, through: :blocks
  belongs_to :zone
  belongs_to :farm
  validates :name, presence: true
  
  def self.tree_amounts(area_id)
    ret_val = 0
    Block.where(:area_id => area_id).each do |b|
      ret_val += b.tree_amount
    end
    ret_val
  end
end
