class Role < ActiveRecord::Base
  include UuidHelper
  attr_reader :resource_tokens
  before_create :resource_tokens

  has_and_belongs_to_many :users, join_table: :users_roles
  # belongs_to :resource, polymorphic: true
  has_many :resources, foreign_key: :resource_id
  # has_and_belongs_to_many :resources, foreign_key: :resource_id

  serialize :resource_type, Array
  
  scopify

  def resource_tokens=(ids)
    puts "================************================"
    resource_ids = ids.split(",")
  end
end
