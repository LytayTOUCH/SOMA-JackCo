class Permission < ActiveRecord::Base
  include UuidHelper
  
  # attr_accessor :access_full, :access_list, :access_create, :access_update, :access_delete
  belongs_to :resource
  belongs_to :user_group
  

  scope :find_by_user_group_id, -> user_group_id { where("user_group_id = ?", "%#{user_group_id}%") }
end
