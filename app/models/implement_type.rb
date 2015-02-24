class ImplementType < ActiveRecord::Base
  include UuidHelper
  
  validates :name, length: { maximum: 50 }, presence: true

  scope :find_by_implement_type_name, -> name { where("name like ?", "%#{name}%") }
end
