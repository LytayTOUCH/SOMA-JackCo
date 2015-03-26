class Production < ActiveRecord::Base
  include UuidHelper

  attr_reader :warehouse_tokens
  before_create :warehouse_tokens

  belongs_to :planting_project, foreign_key: :planting_project_id
  belongs_to :unit_of_measurement, foreign_key: :uom_id

  has_many :warehouse_production_amounts, foreign_key: :production_id 
  has_many :warehouses, through: :warehouse_production_amounts
  has_many :output_tasks

  validates :status, length: { maximum: 20 }, presence: true
  validates :planting_project_id, length: {maximum: 36}, presence: true
  validates :uom_id, length: {maximum: 36}, presence: true

  has_paper_trail

end
