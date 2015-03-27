class MachineryType < ActiveRecord::Base
  include UuidHelper
  
  has_many :machineries
  
  has_paper_trail
end
