class MachineryType < ActiveRecord::Base
  include UuidHelper
  
  has_many :machineries
  
  scope :find_by_name, -> name { where("name like ?", "%#{name}%") }
  
  has_paper_trail
end
