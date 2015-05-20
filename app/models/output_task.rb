class OutputTask < ActiveRecord::Base
  include UuidHelper

  belongs_to :block, foreign_key: :block_id
  belongs_to :zone, foreign_key: :zone_id
  belongs_to :labor
  belongs_to :planting_project
  belongs_to :warehouse_production_amount
  belongs_to :production
  belongs_to :user

  has_many :machineries, through: :output_use_machineries
  has_many :output_use_machineries, foreign_key: :output_id
  
  has_many :equipments, through: :output_use_equipments
  has_many :output_use_equipments, foreign_key: :output_id
  
  has_many :output_distributions
  accepts_nested_attributes_for :machineries

  validates :name, :presence => { message: "Output Task Name can't be blank." }
  validates :start_date, :presence  => { message: "Start Date is required." }
  validates :end_date, :presence => { message: "End Date is required." }
  validates :planting_project_id, length: { maximum: 36 }, :presence => { message: "Planting project is required." }
  validates :tree_amount, :presence => { message: "Tree amount is required." }
  validates :farm_id, length: {maximum: 36}, :presence => { message: "Farm is required." }
  validates :zone_id, length: {maximum: 36}, :presence => { message: "Zone is required." }
  validates :area_id, length: {maximum: 36}, :presence => { message: "Area is required." }
  validates :block_id, length: {maximum: 36}, :presence => { message: "Block is required." }
  validates :labor_id, length: {maximum: 36}, :presence => { message: "Labor is required." }
  validates :reference_number, :presence => { message: "Reference is required." }
  validates :created_by, length: {maximum: 36}, presence: true

  scope :find_by_output_task_name, -> name { where("name like ?", "%#{name}%") }
  
  def self.sum_output_amount(planting_project_id, area_id, start_date, end_date, distribution_id, uom_id)
    begin
      ret_val = 0
      where(:planting_project_id => planting_project_id, :area_id => area_id, :start_date => start_date.beginning_of_day..end_date.end_of_day).each do |o|
        ret_val += o.output_distributions.where(:distribution_id => distribution_id, :unit_measure_id => uom_id).sum(:amount)
      end
      ret_val
    rescue
    end
  end
  
  def self.sum_output_amount_by_farm(planting_project_id, farm_id, start_date, end_date, distribution_id, uom_id)
    begin
      ret_val = 0
      where(:planting_project_id => planting_project_id, :farm_id => farm_id, :start_date => start_date.beginning_of_day..end_date.end_of_day).each do |o|
        ret_val += o.output_distributions.where(:distribution_id => distribution_id, :unit_measure_id => uom_id).sum(:amount)
      end
      ret_val
    rescue
    end
  end
  
  def self.grand_total_output_amount(planting_project_id, start_date, end_date, distribution_id, uom_id)
    begin
      ret_val = 0
      where(:planting_project_id => planting_project_id, :start_date => start_date.beginning_of_day..end_date.end_of_day).each do |o|
        ret_val += o.output_distributions.where(:distribution_id => distribution_id, :unit_measure_id => uom_id).sum(:amount)
      end
      ret_val
    rescue
    end
  end

end
