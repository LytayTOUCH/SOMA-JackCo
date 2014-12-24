class ActivityType < ActiveRecord::Base
  include UuidHelper

  has_one :activity

end
