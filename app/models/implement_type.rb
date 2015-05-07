class ImplementType < ActiveRecord::Base
  include UuidHelper
  
  validates :name, length: { maximum: 50 }, :presence => { message: "Implement Type name is required" }

  scope :find_by_implement_type_name, -> name { where("name like ?", "%#{name}%") }
end
