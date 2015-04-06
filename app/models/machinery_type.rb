class MachineryType < ActiveRecord::Base
  include UuidHelper
  
  has_many :machineries
end
