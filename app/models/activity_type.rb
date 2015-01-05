class ActivityType < ActiveRecord::Base
  include UuidHelper

  has_one :activity

  validates :name, length: { maximum: 50 }

end
