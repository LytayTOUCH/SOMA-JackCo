class MachineryType < ActiveRecord::Base
  include UuidHelper
  
  validates :name, :presence => { message: "Machinery Type name is required." }
  
  has_many :machineries
end
