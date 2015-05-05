class Plan < ActiveRecord::Base
	include UuidHelper
  
  validates :name, length: { maximum: 100 }, :presence => { message: "Plan Name is required." }
  validates :quantity, length: { maximum: 50 }, :presence => { message: "Quantity is required." }
  validates :unit, length: { maximum: 100 }, :presence => { message: "Unit is required." }
  validates :year, length: { maximum: 10 }, :presence => { message: "Year is required." }

  scope :find_by_plan_name, -> name { where("name like ?", "%#{name}%") }

end
