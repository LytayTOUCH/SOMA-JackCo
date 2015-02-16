# Resource is actually a module
class Resource < ActiveRecord::Base
  include UuidHelper

  has_many :permissions, foreign_key: :resource_id    
  has_many :user_groups, through: :permissions

  validates :name, length: { maximum: 50 }, presence: true

  scope :find_by_resource_name, -> name { where("name like ?", "%#{name}%") }
end
