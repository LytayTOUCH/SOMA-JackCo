class AppDescription < ActiveRecord::Base
  include UuidHelper
  
  belongs_to :app, foreign_key: :app_id
end
