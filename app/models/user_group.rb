class UserGroup < ActiveRecord::Base
  include UuidHelper

  has_many :users

  validates :name, length: { maximum: 50 }, :presence => { message: "User group name is required." }

  scope :find_by_user_group_name, -> name { where("name like ?", "%#{name}%") }

end
