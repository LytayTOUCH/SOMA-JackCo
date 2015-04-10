class MachineryType < ActiveRecord::Base
  include UuidHelper
  
  validates :name, presence: true
  
  has_many :machineries
end
