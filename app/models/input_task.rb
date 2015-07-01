class InputTask < ActiveRecord::Base
  include UuidHelper

  belongs_to :zone, foreign_key: :zone_id
  belongs_to :farm, foreign_key: :farm_id
  belongs_to :block, foreign_key: :block_id
  belongs_to :area, foreign_key: :area_id
  belongs_to :labor, foreign_key: :labor_id
  belongs_to :planting_project

  has_many :input_use_materials, foreign_key: :input_id
  has_many :materials, through: :input_use_materials

  has_many :input_use_machineries, foreign_key: :input_id
  has_many :machineries, through: :input_use_machineries

  has_many :input_use_equipments, foreign_key: :input_id
  has_many :equipments, through: :input_use_equipments

  validates :name, length: {maximum: 50}, :presence => { message: "Name can't be blank." }
  validates :start_date, :presence => { message: "Start Date can't be blank." }
  validates :end_date, :presence => { message: "End Date can't be blank." }
  validates :farm_id, length: {maximum: 36}, :presence => { message: "Farm is required." }
  validates :zone_id, length: {maximum: 36}, :presence => { message: "Zone is required." }
  validates :area_id, length: {maximum: 36}, :presence => { message: "Area is required." }
  validates :tree_amount, :presence => { message: "Tree amount is required." }
  validates :labor_id, length: {maximum: 36}, :presence => { message: "Labor is required." }
  validates :reference_number, :presence => { message: "Reference Number can't be blank." }
  validate :end_date_greater_than_start_date
  
  scope :planting_project_id, -> uuid_f { joins(:block).where("blocks.planting_project_id=?", uuid_f) }

  scope :get_period_and_area, -> start_dat, end_dat, area_id, project_id {
    where("start_date >= ? AND start_date <= ? AND area_id = ? AND planting_project_id = ?", 
      start_dat, end_dat, area_id, project_id)
  }  

  scope :get_total_amount, -> start_dat, end_dat, project_id {
    where("start_date >= ? AND start_date <= ? AND planting_project_id = ?", start_dat, end_dat, project_id)
  }

  def end_date_greater_than_start_date
    if (self.start_date.present? && self.end_date.present?)
      errors.add(:end_date, "End date must be greater than Start date") if start_date > end_date
    end
  end
  
  def self.get_total_amount_by_area(start_date, end_date, area_id, material_id, project_name)
    begin
      get_period_and_area(start_date, end_date, area_id, PlantingProject.find_by_project_name(project_name).first.uuid).
        joins(:input_use_materials).
        where("input_use_materials.material_id = ?", material_id).
        group(:area_id, :material_id).
        sum(:material_amount).first[1]
    rescue
      0
    end
  end

  def self.get_total_amount_by_area_machinery(start_date, end_date, area_id, material_id, project_name)
    begin
      get_period_and_area(start_date, end_date, area_id, PlantingProject.find_by_project_name(project_name).first.uuid).
        joins(:input_use_machineries).
        where("input_use_machineries.material_id = ?", material_id).
        group(:area_id, :material_id).
        sum(:material_amount).first[1]
    rescue
      0
    end
  end

  def self.get_total_amount_group_by_material(start_date, end_date, material_id, project_name)
    begin
      get_total_amount(start_date, end_date, PlantingProject.find_by_project_name(project_name).first.uuid).
        joins(:input_use_materials).
        where("input_use_materials.material_id = ?", material_id).
        group(:material_id).
        sum(:material_amount).first[1]
    rescue
      0
    end
  end

  def self.get_total_amount_group_by_machinary(start_date, end_date, material_id, project_name)
    begin
      get_total_amount(start_date, end_date, PlantingProject.find_by_project_name(project_name).first.uuid).
        joins(:input_use_machineries).
        where("input_use_machineries.material_id = ?", material_id).
        group(:material_id).
        sum(:material_amount).first[1]
    rescue
      0
    end
  end
end
