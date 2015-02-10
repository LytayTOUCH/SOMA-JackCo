class Permission < ActiveRecord::Base
  belongs_to :resource
  belongs_to :user_group
end
