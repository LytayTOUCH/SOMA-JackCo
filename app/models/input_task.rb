class InputTask < ActiveRecord::Base
  include UuidHelper

  belongs_to :block, foreign_key: :block_id
  belongs_to :labor, foreign_key: :labor_id
  belongs_to :planting_project

  has_many :input_use_materials, foreign_key: :input_id
  has_many :materials, through: :input_use_materials

  has_many :input_use_machineries, foreign_key: :input_id
  has_many :machineries, through: :input_use_machineries

  has_many :input_use_equipments, foreign_key: :input_id
  has_many :equipments, through: :input_use_equipments

  # validates :name, length: { maximum: 50 }, presence: true
  # validates :start_date, presence: true
  # validates :end_date, presence: true
  # validates :tree_amount, presence: true
  # validates :reference_number, presence: true

  # validates :block_id, length: {maximum: 36}, presence: true
  # validates :labor_id, length: {maximum: 36}, presence: true
  # validates :created_by, length: {maximum: 36}, presence: true
  # validates :planting_project_id, length: {maximum: 36}, presence: true

  validates :name, length: {maximum: 50}, :presence => { message: "Name can't be blank." }
  validates :start_date, :presence => { message: "Start Date can't be blank." }
  validates :end_date, :presence => { message: "End Date can't be blank." }
  validates :block_id, length: {maximum: 36}, :presence => { message: "Block is required." }
  validates :tree_amount, :presence => { message: "Tree amount is required." }
  validates :labor_id, length: {maximum: 36}, :presence => { message: "Labor is required." }
  validates :reference_number, :presence => { message: "Reference Number can't be blank." }
  validate :end_date_greater_than_start_date
  
  scope :planting_project_id, -> uuid_f { joins(:block).where("blocks.planting_project_id=?", uuid_f) }

  scope :start_date, -> start_dat, end_dat {
    if start_dat.present? || end_dat.present?
      if start_dat.blank?
        where("start_date <= ?", end_dat) 
      elsif end_dat.blank?
        where("start_date >= ?", start_dat)
      elsif start_dat.present? && end_dat.present?
        where("start_date >= ? AND start_date <= ?", start_dat, end_dat) 
      else
      end
    end
  }

  def end_date_greater_than_start_date
    if (self.start_date.present? && self.end_date.present?)
      errors.add(:end_date, "End date must be greater than Start date") if start_date > end_date
    end
  end
  
end
