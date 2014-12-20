class Resource < ActiveRecord::Base
  include UuidHelper

  has_many :resource_users, foreign_key: :resource_id    
  has_many :users, through: :resource_users

  validates :name, length: { maximum: 50 }, presence: true
end
