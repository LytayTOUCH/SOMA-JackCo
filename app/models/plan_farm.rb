class PlanFarm < ActiveRecord::Base
  include UuidHelper

  belongs_to :farm, foreign_key: :farm_id

  has_many :plan_phases, foreign_key: :plan_farm_id, dependent: :destroy
  has_many :plan_production_stages, through: :plan_phases
  has_many :plan_production_statuses, through: :plan_production_stages
  has_many :plan_zones, through: :plan_production_statuses
  has_many :plan_areas, through: :plan_zones

  validates_presence_of :farm_id, :message => "Farm can not empty."
  validates_presence_of :for_year, :message => "Year can not empty."

  accepts_nested_attributes_for :plan_phases

  def self.sum_tree_amount(year, farm_id, project_id, production_status_id, area_id)
    begin
      if (farm_id == "All")
        where(planting_project_id: project_id, for_year: year).last.plan_production_statuses
        .where(production_status_id: production_status_id).first.plan_areas
        .where(area_id: area_id).first.plan_blocks
        .sum(:tree_amount)
      else
        where(farm_id: farm_id, planting_project_id: project_id, for_year: year).last.plan_production_statuses
        .where(production_status_id: production_status_id).first.plan_areas
        .where(area_id: area_id).first.plan_blocks
        .sum(:tree_amount)
      end
    rescue
    end
  end

  def self.get_farm_with_zone_area(farm_id)
    unless (farm_id == "All")
      Farm.where(uuid: farm_id).includes(:zones).includes(:areas)
    else
      Farm.all.includes(:zones).includes(:areas)
    end
  end

  def self.sum_area(farm_id)
    @sum_area = 0
    get_farm_with_zone_area(farm_id).each do |farm|
      @sum_area = @sum_area + farm.areas.count
    end
    @sum_area
  end

  def self.get_status_remark(farm_id, project_id, status_uuid, year)
    begin
      if (farm_id == "All")
        where(planting_project_id: project_id, for_year: year).last.plan_production_statuses
        .where(production_status_id: status_uuid).first.remark
      else
        where(farm_id: farm_id, planting_project_id: project_id, for_year: year).last.plan_production_statuses
        .where(production_status_id: status_uuid).first.remark
      end
    rescue
    end
  end
end
