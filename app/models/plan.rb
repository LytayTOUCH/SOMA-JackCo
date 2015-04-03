class Plan < ActiveRecord::Base
	include UuidHelper
  
  validates :name, length: { maximum: 100 }, presence: true
  validates :quantity, length: { maximum: 50 }, presence: true
  validates :unit, length: { maximum: 100 }, presence: true
  validates :year, length: { maximum: 10 }, presence: true

  scope :find_by_plan_name, -> name { where("name like ?", "%#{name}%") }

end
