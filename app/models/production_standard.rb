class ProductionStandard < ActiveRecord::Base
  include UuidHelper

  belongs_to :planting_project

  validates_presence_of :for_year, :message => "Year can not be blank."
  validates_presence_of :planting_project_id, :message => "Project name can not be blank."
  
  def self.total_standard_a_year(planting_project_id, year)
    begin
      ret_val = 0
      
      unless ProductionStandard.find_by(planting_project_id: planting_project_id, for_year: year).nil?
        p = ProductionStandard.find_by(planting_project_id: planting_project_id, for_year: year)
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
