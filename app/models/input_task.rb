class InputTask < ActiveRecord::Base
	include UuidHelper

	belongs_to :block, foreign_key: :block_id
	belongs_to :labor, foreign_key: :labor_id
	belongs_to :planting_project

	has_many :input_use_materials, foreign_key: :input_id
	has_many :materials, through: :input_use_materials

  	has_many :input_use_machineries, foreign_key: :input_id
  	has_many :machineries, through: :input_use_machineries

	validates :name, length: { maximum: 50 }, presence: true
	validates :start_date, presence: true
	validates :end_date, presence: true
	validates :tree_amount, presence: true
	validates :reference_number, presence: true
	# validates :material_amount, presence: true

  	validates :block_id, length: {maximum: 36}, presence: true
  	validates :labor_id, length: {maximum: 36}, presence: true
  	# validates :warehouse_id, length: {maximum: 36}, presence: true
  	# validates :material_id, length: {maximum: 36}, presence: true
  	validates :created_by, length: {maximum: 36}, presence: true

  	scope :find_by_name, -> name { where("name like ?", "%#{name}%") }
  	scope :planting_project_id, -> uuid_f { joins(:block).where("blocks.planting_project_id=?", uuid_f) }

  	scope :start_date, -> start_date, end_date {
		if start_date.present? || end_date.present?
			if start_date.blank?
				where("start_date <= ?", end_date ) 
			elsif end_date.blank?
				where("start_date >= ?", start_date ) 
			elsif start_date.present? && end_date.present?
				where("start_date >= ? AND start_date <= ?", start_date, end_date ) 
			else
			end
		end

	}
end
