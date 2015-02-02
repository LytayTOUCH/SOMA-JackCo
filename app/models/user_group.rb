class UserGroup < ActiveRecord::Base
  include UuidHelper

  has_many :users
  has_many :permissions, foreign_key: :user_group_id 
  has_many :resources, through: :permissions
  validates :name, length: { maximum: 50 }, presence: true
end
