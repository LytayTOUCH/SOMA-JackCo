class Role < ActiveRecord::Base
  include UuidHelper

  has_and_belongs_to_many :users, :join_table => :users_roles
  # belongs_to :resource
  has_many :resources

  serialize :resource_type, Array
  
  scopify
end