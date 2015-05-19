class ProductionPlan < ActiveRecord::Base
  include UuidHelper

  has_many :production_classification_amounts, foreign_key: :production_plan_id

  validates_presence_of :planting_project_id, :message => "Project name can't be blank."
  validates_presence_of :for_year, :message => "Year can't be blank."
  validates_uniqueness_of :planting_project_id, :scope => :for_year, :message => "This project name and year are already existed."

  accepts_nested_attributes_for :production_classification_amounts

  def self.total_plan_a_year(planting_project_id, year)
    begin
      ret_val = 0
      
      unless ProductionPlan.find_by(planting_project_id: planting_project_id, for_year: year).nil?
        p = ProductionPlan.find_by(planting_project_id: planting_project_id, for_year: year)
        jan = p.jan
        feb = p.feb
        mar = p.mar
        apr = p.apr
        may = p.may
        jun = p.jun
        jul = p.jul
        aug = p.aug
        sep = p.sep
        oct = p.oct
        nov = p.nov
        dec = p.dec
        
        ret_val = jan + feb + mar + apr + may + jun + jul + aug + sep + oct + nov + dec
      end
      
      ret_val
    rescue
    end
  end
end
