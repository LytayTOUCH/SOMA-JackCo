class Labor < ActiveRecord::Base
  include UuidHelper

  validates :name, length: { maximum: 50 }, :presence => { message: "Labor Name is required." }
  validates :position_id, length: { maximum: 36 }, :presence => { message: "Positon is required." }
  validates :gender, :presence => { message: "Gender is required." }
  # validates :email, :presence => { message: "Email is required." }

  has_many :labors
  has_many :stock_ins
  has_many :output_tasks

  has_one :user

  belongs_to :labor, foreign_key: :manager_uuid

  belongs_to :position, foreign_key: :position_id

  has_many :input_tasks, foreign_key: :labor_id

  scope :find_by_labor_name, -> name { where("name like ?", "%#{name}%") }
  
end
