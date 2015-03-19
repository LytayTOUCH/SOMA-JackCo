class UserGroup < ActiveRecord::Base
  include UuidHelper

  has_many :users

  validates :name, length: { maximum: 50 }, presence: true

  scope :find_by_user_group_name, -> name { where("name like ?", "%#{name}%") }

  has_paper_trail

end
