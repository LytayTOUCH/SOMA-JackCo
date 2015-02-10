class UserGroup < ActiveRecord::Base
  include UuidHelper

  attr_reader :resource_tokens
  before_create :resource_tokens

  has_many :users
  
  has_many :permissions, foreign_key: :user_group_id 
  has_many :resources, through: :permissions
  
  validates :name, length: { maximum: 50 }, presence: true

  def resource_tokens=(ids)
    puts "================************================"
    resource_ids = ids.split(",")
  end

  scope :find_by_name, -> name { where("name like ?", "%#{name}%") }
end
