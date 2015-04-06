class Log < ActiveRecord::Base
  include UuidHelper
  
  belongs_to :user, foreign_key: :user_id
end
