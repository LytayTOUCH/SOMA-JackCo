class InputTask < ActiveRecord::Base
	include UuidHelper

	belongs_to :block, foreign_key: :block_id
	belongs_to :labor, foreign_key: :labor_id
	belongs_to :warehouse, foreign_key: :warehouse_id
	belongs_to :material, foreign_key: :material_id
	belongs_to :machinery, foreign_key: :machinery_id

	validates :name, length: { maximum: 50 }, presence: true
	validates :start_date, presence: true
	validates :end_date, presence: true
	validates :tree_amount, presence: true
	validates :reference_number, presence: true
	validates :material_amount, presence: true

  	validates :block_id, length: {maximum: 36}, presence: true
  	validates :labor_id, length: {maximum: 36}, presence: true
  	validates :warehouse_id, length: {maximum: 36}, presence: true
  	validates :material_id, length: {maximum: 36}, presence: true
  	validates :created_by, length: {maximum: 36}, presence: true

  	scope :find_by_name, -> name { where("name like ?", "%#{name}%") }
  	scope :planting_project_id, -> uuid_f { joins(:block).where("blocks.planting_project_id=?", uuid_f) }

  	has_paper_trail
end
