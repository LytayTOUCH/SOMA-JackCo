class UserGroup < ActiveRecord::Base
  include UuidHelper

  attr_reader :resource_tokens
  before_create :resource_tokens

  # attr_accessor :access_full, :access_list, :access_create, :access_update, :access_delete

  has_many :users
  
  has_many :permissions, foreign_key: :user_group_id 
  has_many :resources, through: :permissions
  # accepts_nested_attributes_for :permissions
  
  validates :name, length: { maximum: 50 }, presence: true

  def resource_tokens=(ids)
    puts "================************================"
    resource_ids = ids.split(",")
    puts "================************================"
  end

  scope :find_by_name, -> name { where("name like ?", "%#{name}%") }
end
