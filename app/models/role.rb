class Role < ActiveRecord::Base
  include UuidHelper

  has_paper_trail
  
end
