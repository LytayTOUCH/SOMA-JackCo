class OutputTask < ActiveRecord::Base
  include UuidHelper

  belongs_to :block, foreign_key: :block_id
  belongs_to :labor
  belongs_to :planting_project
  belongs_to :warehouse_production_amount
  belongs_to :production
  belongs_to :user

  has_many :machineries, through: :output_use_machineries
  has_many :output_use_machineries, foreign_key: :output_id
  accepts_nested_attributes_for :machineries

  validates :name, length: { maximum: 50 }, :presence => { message: "Output Task Name can't be blank." }
  validates :start_date, :presence  => { message: "Start Date is required." }
  validates :end_date, :presence => { message: "End Date is required." }
  validates :planting_project_id, length: { maximum: 36 }, :presence => { message: "Planting project is required." }
  validates :block_id, length: {maximum: 36}, :presence => { message: "Block is required." }
  validates :labor_id, length: {maximum: 36}, :presence => { message: "Labor is required." }
  validates :finish_production_id, length: {maximum: 36}, :presence => { message: "Finish production status is required." }
  validates :finish_warehouse_id, length: {maximum: 36}, :presence => { message: "Finish Warehouse is required." }
  validates :nursery_production_id, length: {maximum: 36}, :presence => { message: "Nursery production status is required." }
  validates :nursery_warehouse_id, length: {maximum: 36}, :presence => { message: "Nurseery Warehouse is required." }
  validates :created_by, length: {maximum: 36}, presence: true

  scope :find_by_output_task_name, -> name { where("name like ?", "%#{name}%") }

end
