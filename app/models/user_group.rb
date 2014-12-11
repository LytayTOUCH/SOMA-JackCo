class UserGroup < ActiveRecord::Base
  include UuidHelper
  resourcify
  
  validates :name, length: { maximum: 50 }, presence: true

end
