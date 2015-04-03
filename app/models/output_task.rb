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

  validates :name, length: { maximum: 50 }, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :planting_project_id, length: { maximum: 36 }, presence: true
  validates :block_id, length: {maximum: 36}, presence: true
  validates :labor_id, length: {maximum: 36}, presence: true
  validates :finish_production_id, length: {maximum: 36}, presence: true
  validates :finish_warehouse_id, length: {maximum: 36}, presence: true
  validates :nursery_production_id, length: {maximum: 36}, presence: true
  validates :nursery_warehouse_id, length: {maximum: 36}, presence: true
  validates :created_by, length: {maximum: 36}, presence: true

  scope :find_by_output_task_name, -> name { where("name like ?", "%#{name}%") }

end
