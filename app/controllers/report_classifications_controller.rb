require 'date'

class ReportClassificationsController < ApplicationController
  def coconut_index
    @coconut = PlantingProject.find_by_name("Coconut")
    @unit = UnitOfMeasurement.find_by_name("Unit")
    
    if !params[:filter].nil? && params[:filter][:year]!=""
      @year = params[:filter][:year]
      @feb_str = Date.leap?(@year.to_i) ? "-02-29" : "-02-28"
      
      unless ProductionStandard.find_by(planting_project_id: @coconut.uuid, for_year: @year).nil?
        jan = ProductionStandard.find_by(planting_project_id: @coconut.uuid, for_year: @year).jan
        feb = ProductionStandard.find_by(planting_project_id: @coconut.uuid, for_year: @year).feb
        mar = ProductionStandard.find_by(planting_project_id: @coconut.uuid, for_year: @year).mar
        apr = ProductionStandard.find_by(planting_project_id: @coconut.uuid, for_year: @year).apr
        may = ProductionStandard.find_by(planting_project_id: @coconut.uuid, for_year: @year).may
        jun = ProductionStandard.find_by(planting_project_id: @coconut.uuid, for_year: @year).jun
        jul = ProductionStandard.find_by(planting_project_id: @coconut.uuid, for_year: @year).jul
        aug = ProductionStandard.find_by(planting_project_id: @coconut.uuid, for_year: @year).aug
        sep = ProductionStandard.find_by(planting_project_id: @coconut.uuid, for_year: @year).sep
        oct = ProductionStandard.find_by(planting_project_id: @coconut.uuid, for_year: @year).oct
        nov = ProductionStandard.find_by(planting_project_id: @coconut.uuid, for_year: @year).nov
        dec = ProductionStandard.find_by(planting_project_id: @coconut.uuid, for_year: @year).dec
        
        total = jan + feb + mar + apr + may + jun + jul + aug + sep + oct + nov + dec
        
        @production_standard = [jan,feb,mar,apr,may,jun,jul,aug,sep,oct,nov,dec,total]
      else
        @production_standard = [0,0,0,0,0,0,0,0,0,0,0,0,0]
      end
      
      unless ProductionPlan.find_by(planting_project_id: @coconut.uuid, for_year: @year).nil?
        jan = ProductionPlan.find_by(planting_project_id: @coconut.uuid, for_year: @year).jan
        feb = ProductionPlan.find_by(planting_project_id: @coconut.uuid, for_year: @year).feb
        mar = ProductionPlan.find_by(planting_project_id: @coconut.uuid, for_year: @year).mar
        apr = ProductionPlan.find_by(planting_project_id: @coconut.uuid, for_year: @year).apr
        may = ProductionPlan.find_by(planting_project_id: @coconut.uuid, for_year: @year).may
        jun = ProductionPlan.find_by(planting_project_id: @coconut.uuid, for_year: @year).jun
        jul = ProductionPlan.find_by(planting_project_id: @coconut.uuid, for_year: @year).jul
        aug = ProductionPlan.find_by(planting_project_id: @coconut.uuid, for_year: @year).aug
        sep = ProductionPlan.find_by(planting_project_id: @coconut.uuid, for_year: @year).sep
        oct = ProductionPlan.find_by(planting_project_id: @coconut.uuid, for_year: @year).oct
        nov = ProductionPlan.find_by(planting_project_id: @coconut.uuid, for_year: @year).nov
        dec = ProductionPlan.find_by(planting_project_id: @coconut.uuid, for_year: @year).dec
        
        total = jan + feb + mar + apr + may + jun + jul + aug + sep + oct + nov + dec
        
        @production_plan = [jan,feb,mar,apr,may,jun,jul,aug,sep,oct,nov,dec,total]
      else
        @production_plan = [0,0,0,0,0,0,0,0,0,0,0,0,0]
      end
      
      if params[:filter][:farm_id]!="g_total"
        @farm = Farm.find_by_uuid(params[:filter][:farm_id])
        
        @actual_pdts = [
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-01-31"), "00000000-0000-0000-0000-000000000001", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-02-01"), Date.parse(@year+@feb_str), "00000000-0000-0000-0000-000000000001", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-03-01"), Date.parse(@year+"-03-31"), "00000000-0000-0000-0000-000000000001", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-04-01"), Date.parse(@year+"-04-30"), "00000000-0000-0000-0000-000000000001", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-05-01"), Date.parse(@year+"-05-31"), "00000000-0000-0000-0000-000000000001", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-06-01"), Date.parse(@year+"-06-30"), "00000000-0000-0000-0000-000000000001", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-07-01"), Date.parse(@year+"-07-31"), "00000000-0000-0000-0000-000000000001", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-08-01"), Date.parse(@year+"-08-31"), "00000000-0000-0000-0000-000000000001", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-09-01"), Date.parse(@year+"-09-30"), "00000000-0000-0000-0000-000000000001", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-10-01"), Date.parse(@year+"-10-31"), "00000000-0000-0000-0000-000000000001", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-11-01"), Date.parse(@year+"-11-30"), "00000000-0000-0000-0000-000000000001", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-12-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000001", @unit.uuid),
          
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000001", @unit.uuid)
        ]
        
        @to_finish_whs = [
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-01-31"), "00000000-0000-0000-0000-000000000008", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-02-01"), Date.parse(@year+@feb_str), "00000000-0000-0000-0000-000000000008", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-03-01"), Date.parse(@year+"-03-31"), "00000000-0000-0000-0000-000000000008", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-04-01"), Date.parse(@year+"-04-30"), "00000000-0000-0000-0000-000000000008", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-05-01"), Date.parse(@year+"-05-31"), "00000000-0000-0000-0000-000000000008", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-06-01"), Date.parse(@year+"-06-30"), "00000000-0000-0000-0000-000000000008", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-07-01"), Date.parse(@year+"-07-31"), "00000000-0000-0000-0000-000000000008", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-08-01"), Date.parse(@year+"-08-31"), "00000000-0000-0000-0000-000000000008", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-09-01"), Date.parse(@year+"-09-30"), "00000000-0000-0000-0000-000000000008", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-10-01"), Date.parse(@year+"-10-31"), "00000000-0000-0000-0000-000000000008", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-11-01"), Date.parse(@year+"-11-30"), "00000000-0000-0000-0000-000000000008", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-12-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000008", @unit.uuid),
          
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000008", @unit.uuid)
        ]
        
        @to_nursery_whs = [
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-01-31"), "00000000-0000-0000-0000-000000000011", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-02-01"), Date.parse(@year+@feb_str), "00000000-0000-0000-0000-000000000011", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-03-01"), Date.parse(@year+"-03-31"), "00000000-0000-0000-0000-000000000011", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-04-01"), Date.parse(@year+"-04-30"), "00000000-0000-0000-0000-000000000011", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-05-01"), Date.parse(@year+"-05-31"), "00000000-0000-0000-0000-000000000011", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-06-01"), Date.parse(@year+"-06-30"), "00000000-0000-0000-0000-000000000011", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-07-01"), Date.parse(@year+"-07-31"), "00000000-0000-0000-0000-000000000011", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-08-01"), Date.parse(@year+"-08-31"), "00000000-0000-0000-0000-000000000011", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-09-01"), Date.parse(@year+"-09-30"), "00000000-0000-0000-0000-000000000011", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-10-01"), Date.parse(@year+"-10-31"), "00000000-0000-0000-0000-000000000011", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-11-01"), Date.parse(@year+"-11-30"), "00000000-0000-0000-0000-000000000011", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-12-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000011", @unit.uuid),
          
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000011", @unit.uuid)
        ]
        
        @spoiled = [
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-01-31"), "00000000-0000-0000-0000-000000000010", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-02-01"), Date.parse(@year+@feb_str), "00000000-0000-0000-0000-000000000010", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-03-01"), Date.parse(@year+"-03-31"), "00000000-0000-0000-0000-000000000010", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-04-01"), Date.parse(@year+"-04-30"), "00000000-0000-0000-0000-000000000010", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-05-01"), Date.parse(@year+"-05-31"), "00000000-0000-0000-0000-000000000010", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-06-01"), Date.parse(@year+"-06-30"), "00000000-0000-0000-0000-000000000010", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-07-01"), Date.parse(@year+"-07-31"), "00000000-0000-0000-0000-000000000010", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-08-01"), Date.parse(@year+"-08-31"), "00000000-0000-0000-0000-000000000010", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-09-01"), Date.parse(@year+"-09-30"), "00000000-0000-0000-0000-000000000010", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-10-01"), Date.parse(@year+"-10-31"), "00000000-0000-0000-0000-000000000010", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-11-01"), Date.parse(@year+"-11-30"), "00000000-0000-0000-0000-000000000010", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-12-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000010", @unit.uuid),
          
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000010", @unit.uuid)
        ]
        
        @free_at_farm = [
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-01-31"), "00000000-0000-0000-0000-000000000009", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-02-01"), Date.parse(@year+@feb_str), "00000000-0000-0000-0000-000000000009", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-03-01"), Date.parse(@year+"-03-31"), "00000000-0000-0000-0000-000000000009", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-04-01"), Date.parse(@year+"-04-30"), "00000000-0000-0000-0000-000000000009", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-05-01"), Date.parse(@year+"-05-31"), "00000000-0000-0000-0000-000000000009", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-06-01"), Date.parse(@year+"-06-30"), "00000000-0000-0000-0000-000000000009", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-07-01"), Date.parse(@year+"-07-31"), "00000000-0000-0000-0000-000000000009", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-08-01"), Date.parse(@year+"-08-31"), "00000000-0000-0000-0000-000000000009", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-09-01"), Date.parse(@year+"-09-30"), "00000000-0000-0000-0000-000000000009", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-10-01"), Date.parse(@year+"-10-31"), "00000000-0000-0000-0000-000000000009", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-11-01"), Date.parse(@year+"-11-30"), "00000000-0000-0000-0000-000000000009", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-12-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000009", @unit.uuid),
          
          OutputTask.sum_output_amount_by_farm(@coconut.uuid, @farm.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000009", @unit.uuid)
        ]
      else
        @actual_pdts = [
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-01-31"), "00000000-0000-0000-0000-000000000001", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-02-01"), Date.parse(@year+@feb_str), "00000000-0000-0000-0000-000000000001", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-03-01"), Date.parse(@year+"-03-31"), "00000000-0000-0000-0000-000000000001", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-04-01"), Date.parse(@year+"-04-30"), "00000000-0000-0000-0000-000000000001", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-05-01"), Date.parse(@year+"-05-31"), "00000000-0000-0000-0000-000000000001", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-06-01"), Date.parse(@year+"-06-30"), "00000000-0000-0000-0000-000000000001", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-07-01"), Date.parse(@year+"-07-31"), "00000000-0000-0000-0000-000000000001", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-08-01"), Date.parse(@year+"-08-31"), "00000000-0000-0000-0000-000000000001", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-09-01"), Date.parse(@year+"-09-30"), "00000000-0000-0000-0000-000000000001", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-10-01"), Date.parse(@year+"-10-31"), "00000000-0000-0000-0000-000000000001", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-11-01"), Date.parse(@year+"-11-30"), "00000000-0000-0000-0000-000000000001", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-12-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000001", @unit.uuid),
          
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000001", @unit.uuid)
        ]
        
        @to_finish_whs = [
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-01-31"), "00000000-0000-0000-0000-000000000008", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-02-01"), Date.parse(@year+@feb_str), "00000000-0000-0000-0000-000000000008", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-03-01"), Date.parse(@year+"-03-31"), "00000000-0000-0000-0000-000000000008", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-04-01"), Date.parse(@year+"-04-30"), "00000000-0000-0000-0000-000000000008", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-05-01"), Date.parse(@year+"-05-31"), "00000000-0000-0000-0000-000000000008", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-06-01"), Date.parse(@year+"-06-30"), "00000000-0000-0000-0000-000000000008", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-07-01"), Date.parse(@year+"-07-31"), "00000000-0000-0000-0000-000000000008", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-08-01"), Date.parse(@year+"-08-31"), "00000000-0000-0000-0000-000000000008", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-09-01"), Date.parse(@year+"-09-30"), "00000000-0000-0000-0000-000000000008", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-10-01"), Date.parse(@year+"-10-31"), "00000000-0000-0000-0000-000000000008", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-11-01"), Date.parse(@year+"-11-30"), "00000000-0000-0000-0000-000000000008", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-12-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000008", @unit.uuid),
          
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000008", @unit.uuid)
        ]
        
        @to_nursery_whs = [
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-01-31"), "00000000-0000-0000-0000-000000000011", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-02-01"), Date.parse(@year+@feb_str), "00000000-0000-0000-0000-000000000011", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-03-01"), Date.parse(@year+"-03-31"), "00000000-0000-0000-0000-000000000011", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-04-01"), Date.parse(@year+"-04-30"), "00000000-0000-0000-0000-000000000011", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-05-01"), Date.parse(@year+"-05-31"), "00000000-0000-0000-0000-000000000011", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-06-01"), Date.parse(@year+"-06-30"), "00000000-0000-0000-0000-000000000011", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-07-01"), Date.parse(@year+"-07-31"), "00000000-0000-0000-0000-000000000011", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-08-01"), Date.parse(@year+"-08-31"), "00000000-0000-0000-0000-000000000011", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-09-01"), Date.parse(@year+"-09-30"), "00000000-0000-0000-0000-000000000011", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-10-01"), Date.parse(@year+"-10-31"), "00000000-0000-0000-0000-000000000011", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-11-01"), Date.parse(@year+"-11-30"), "00000000-0000-0000-0000-000000000011", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-12-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000011", @unit.uuid),
          
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000011", @unit.uuid)
        ]
        
        @spoiled = [
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-01-31"), "00000000-0000-0000-0000-000000000010", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-02-01"), Date.parse(@year+@feb_str), "00000000-0000-0000-0000-000000000010", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-03-01"), Date.parse(@year+"-03-31"), "00000000-0000-0000-0000-000000000010", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-04-01"), Date.parse(@year+"-04-30"), "00000000-0000-0000-0000-000000000010", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-05-01"), Date.parse(@year+"-05-31"), "00000000-0000-0000-0000-000000000010", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-06-01"), Date.parse(@year+"-06-30"), "00000000-0000-0000-0000-000000000010", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-07-01"), Date.parse(@year+"-07-31"), "00000000-0000-0000-0000-000000000010", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-08-01"), Date.parse(@year+"-08-31"), "00000000-0000-0000-0000-000000000010", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-09-01"), Date.parse(@year+"-09-30"), "00000000-0000-0000-0000-000000000010", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-10-01"), Date.parse(@year+"-10-31"), "00000000-0000-0000-0000-000000000010", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-11-01"), Date.parse(@year+"-11-30"), "00000000-0000-0000-0000-000000000010", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-12-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000010", @unit.uuid),
          
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000010", @unit.uuid)
        ]
        
        @free_at_farm = [
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-01-31"), "00000000-0000-0000-0000-000000000009", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-02-01"), Date.parse(@year+@feb_str), "00000000-0000-0000-0000-000000000009", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-03-01"), Date.parse(@year+"-03-31"), "00000000-0000-0000-0000-000000000009", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-04-01"), Date.parse(@year+"-04-30"), "00000000-0000-0000-0000-000000000009", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-05-01"), Date.parse(@year+"-05-31"), "00000000-0000-0000-0000-000000000009", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-06-01"), Date.parse(@year+"-06-30"), "00000000-0000-0000-0000-000000000009", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-07-01"), Date.parse(@year+"-07-31"), "00000000-0000-0000-0000-000000000009", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-08-01"), Date.parse(@year+"-08-31"), "00000000-0000-0000-0000-000000000009", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-09-01"), Date.parse(@year+"-09-30"), "00000000-0000-0000-0000-000000000009", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-10-01"), Date.parse(@year+"-10-31"), "00000000-0000-0000-0000-000000000009", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-11-01"), Date.parse(@year+"-11-30"), "00000000-0000-0000-0000-000000000009", @unit.uuid),
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-12-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000009", @unit.uuid),
          
          OutputTask.grand_total_output_amount(@coconut.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000009", @unit.uuid)
        ]
      end
    end
  end

  def jackfruit_index
    @jackfruit = PlantingProject.find_by_name("Jackfruit")
    @unit = UnitOfMeasurement.find_by_name("Unit")
    @kg = UnitOfMeasurement.find_by_name("Kg")
    
    if !params[:filter].nil? && params[:filter][:year]!=""
      @year = params[:filter][:year]
      @feb_str = Date.leap?(@year.to_i) ? "-02-29" : "-02-28"
      
      unless ProductionStandard.find_by(planting_project_id: @jackfruit.uuid, for_year: @year).nil?
        jan = ProductionStandard.find_by(planting_project_id: @jackfruit.uuid, for_year: @year).jan
        feb = ProductionStandard.find_by(planting_project_id: @jackfruit.uuid, for_year: @year).feb
        mar = ProductionStandard.find_by(planting_project_id: @jackfruit.uuid, for_year: @year).mar
        apr = ProductionStandard.find_by(planting_project_id: @jackfruit.uuid, for_year: @year).apr
        may = ProductionStandard.find_by(planting_project_id: @jackfruit.uuid, for_year: @year).may
        jun = ProductionStandard.find_by(planting_project_id: @jackfruit.uuid, for_year: @year).jun
        jul = ProductionStandard.find_by(planting_project_id: @jackfruit.uuid, for_year: @year).jul
        aug = ProductionStandard.find_by(planting_project_id: @jackfruit.uuid, for_year: @year).aug
        sep = ProductionStandard.find_by(planting_project_id: @jackfruit.uuid, for_year: @year).sep
        oct = ProductionStandard.find_by(planting_project_id: @jackfruit.uuid, for_year: @year).oct
        nov = ProductionStandard.find_by(planting_project_id: @jackfruit.uuid, for_year: @year).nov
        dec = ProductionStandard.find_by(planting_project_id: @jackfruit.uuid, for_year: @year).dec
        
        total = jan + feb + mar + apr + may + jun + jul + aug + sep + oct + nov + dec
        
        @production_standard = [jan,feb,mar,apr,may,jun,jul,aug,sep,oct,nov,dec,total]
      else
        @production_standard = [0,0,0,0,0,0,0,0,0,0,0,0,0]
      end
      
      unless ProductionPlan.find_by(planting_project_id: @jackfruit.uuid, for_year: @year).nil?
        jan = ProductionPlan.find_by(planting_project_id: @jackfruit.uuid, for_year: @year).jan
        feb = ProductionPlan.find_by(planting_project_id: @jackfruit.uuid, for_year: @year).feb
        mar = ProductionPlan.find_by(planting_project_id: @jackfruit.uuid, for_year: @year).mar
        apr = ProductionPlan.find_by(planting_project_id: @jackfruit.uuid, for_year: @year).apr
        may = ProductionPlan.find_by(planting_project_id: @jackfruit.uuid, for_year: @year).may
        jun = ProductionPlan.find_by(planting_project_id: @jackfruit.uuid, for_year: @year).jun
        jul = ProductionPlan.find_by(planting_project_id: @jackfruit.uuid, for_year: @year).jul
        aug = ProductionPlan.find_by(planting_project_id: @jackfruit.uuid, for_year: @year).aug
        sep = ProductionPlan.find_by(planting_project_id: @jackfruit.uuid, for_year: @year).sep
        oct = ProductionPlan.find_by(planting_project_id: @jackfruit.uuid, for_year: @year).oct
        nov = ProductionPlan.find_by(planting_project_id: @jackfruit.uuid, for_year: @year).nov
        dec = ProductionPlan.find_by(planting_project_id: @jackfruit.uuid, for_year: @year).dec
        
        total = jan + feb + mar + apr + may + jun + jul + aug + sep + oct + nov + dec
        
        @production_plan = [jan,feb,mar,apr,may,jun,jul,aug,sep,oct,nov,dec,total]
      else
        @production_plan = [0,0,0,0,0,0,0,0,0,0,0,0,0]
      end
      
      if params[:filter][:farm_id]!="g_total"
        @farm = Farm.find_by_uuid(params[:filter][:farm_id])
        
        #----------- START - ACTUAL ------------
        @actual_pdt_unit = [
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-01-31"), "00000000-0000-0000-0000-000000000012", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-02-01"), Date.parse(@year+@feb_str), "00000000-0000-0000-0000-000000000012", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-03-01"), Date.parse(@year+"-03-31"), "00000000-0000-0000-0000-000000000012", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-04-01"), Date.parse(@year+"-04-30"), "00000000-0000-0000-0000-000000000012", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-05-01"), Date.parse(@year+"-05-31"), "00000000-0000-0000-0000-000000000012", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-06-01"), Date.parse(@year+"-06-30"), "00000000-0000-0000-0000-000000000012", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-07-01"), Date.parse(@year+"-07-31"), "00000000-0000-0000-0000-000000000012", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-08-01"), Date.parse(@year+"-08-31"), "00000000-0000-0000-0000-000000000012", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-09-01"), Date.parse(@year+"-09-30"), "00000000-0000-0000-0000-000000000012", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-10-01"), Date.parse(@year+"-10-31"), "00000000-0000-0000-0000-000000000012", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-11-01"), Date.parse(@year+"-11-30"), "00000000-0000-0000-0000-000000000012", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-12-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000012", @unit.uuid),
          
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000012", @unit.uuid)
        ]
        @actual_pdt_kg = [
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-01-31"), "00000000-0000-0000-0000-000000000012", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-02-01"), Date.parse(@year+@feb_str), "00000000-0000-0000-0000-000000000012", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-03-01"), Date.parse(@year+"-03-31"), "00000000-0000-0000-0000-000000000012", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-04-01"), Date.parse(@year+"-04-30"), "00000000-0000-0000-0000-000000000012", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-05-01"), Date.parse(@year+"-05-31"), "00000000-0000-0000-0000-000000000012", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-06-01"), Date.parse(@year+"-06-30"), "00000000-0000-0000-0000-000000000012", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-07-01"), Date.parse(@year+"-07-31"), "00000000-0000-0000-0000-000000000012", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-08-01"), Date.parse(@year+"-08-31"), "00000000-0000-0000-0000-000000000012", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-09-01"), Date.parse(@year+"-09-30"), "00000000-0000-0000-0000-000000000012", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-10-01"), Date.parse(@year+"-10-31"), "00000000-0000-0000-0000-000000000012", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-11-01"), Date.parse(@year+"-11-30"), "00000000-0000-0000-0000-000000000012", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-12-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000012", @kg.uuid),
          
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000012", @kg.uuid)
        ]
        #------------- END - ACTUAL ------------
        
        
        #-------------- START - TO FINISH WH ----------------
        @to_finish_wh_unit = [
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-01-31"), "00000000-0000-0000-0000-000000000019", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-02-01"), Date.parse(@year+@feb_str), "00000000-0000-0000-0000-000000000019", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-03-01"), Date.parse(@year+"-03-31"), "00000000-0000-0000-0000-000000000019", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-04-01"), Date.parse(@year+"-04-30"), "00000000-0000-0000-0000-000000000019", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-05-01"), Date.parse(@year+"-05-31"), "00000000-0000-0000-0000-000000000019", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-06-01"), Date.parse(@year+"-06-30"), "00000000-0000-0000-0000-000000000019", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-07-01"), Date.parse(@year+"-07-31"), "00000000-0000-0000-0000-000000000019", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-08-01"), Date.parse(@year+"-08-31"), "00000000-0000-0000-0000-000000000019", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-09-01"), Date.parse(@year+"-09-30"), "00000000-0000-0000-0000-000000000019", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-10-01"), Date.parse(@year+"-10-31"), "00000000-0000-0000-0000-000000000019", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-11-01"), Date.parse(@year+"-11-30"), "00000000-0000-0000-0000-000000000019", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-12-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000019", @unit.uuid),
          
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000019", @unit.uuid)
        ]
        @to_finish_wh_kg = [
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-01-31"), "00000000-0000-0000-0000-000000000019", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-02-01"), Date.parse(@year+@feb_str), "00000000-0000-0000-0000-000000000019", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-03-01"), Date.parse(@year+"-03-31"), "00000000-0000-0000-0000-000000000019", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-04-01"), Date.parse(@year+"-04-30"), "00000000-0000-0000-0000-000000000019", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-05-01"), Date.parse(@year+"-05-31"), "00000000-0000-0000-0000-000000000019", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-06-01"), Date.parse(@year+"-06-30"), "00000000-0000-0000-0000-000000000019", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-07-01"), Date.parse(@year+"-07-31"), "00000000-0000-0000-0000-000000000019", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-08-01"), Date.parse(@year+"-08-31"), "00000000-0000-0000-0000-000000000019", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-09-01"), Date.parse(@year+"-09-30"), "00000000-0000-0000-0000-000000000019", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-10-01"), Date.parse(@year+"-10-31"), "00000000-0000-0000-0000-000000000019", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-11-01"), Date.parse(@year+"-11-30"), "00000000-0000-0000-0000-000000000019", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-12-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000019", @kg.uuid),
          
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000019", @kg.uuid)
        ]
        #-------------- END - TO FINISH WH ----------------
        
        
        #-------------- START - TO NURSERY WH ----------------
        @to_nursery_wh_unit = [
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-01-31"), "00000000-0000-0000-0000-000000000018", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-02-01"), Date.parse(@year+@feb_str), "00000000-0000-0000-0000-000000000018", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-03-01"), Date.parse(@year+"-03-31"), "00000000-0000-0000-0000-000000000018", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-04-01"), Date.parse(@year+"-04-30"), "00000000-0000-0000-0000-000000000018", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-05-01"), Date.parse(@year+"-05-31"), "00000000-0000-0000-0000-000000000018", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-06-01"), Date.parse(@year+"-06-30"), "00000000-0000-0000-0000-000000000018", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-07-01"), Date.parse(@year+"-07-31"), "00000000-0000-0000-0000-000000000018", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-08-01"), Date.parse(@year+"-08-31"), "00000000-0000-0000-0000-000000000018", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-09-01"), Date.parse(@year+"-09-30"), "00000000-0000-0000-0000-000000000018", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-10-01"), Date.parse(@year+"-10-31"), "00000000-0000-0000-0000-000000000018", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-11-01"), Date.parse(@year+"-11-30"), "00000000-0000-0000-0000-000000000018", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-12-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000018", @unit.uuid),
          
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000018", @unit.uuid)
        ]
        @to_nursery_wh_kg = [
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-01-31"), "00000000-0000-0000-0000-000000000018", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-02-01"), Date.parse(@year+@feb_str), "00000000-0000-0000-0000-000000000018", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-03-01"), Date.parse(@year+"-03-31"), "00000000-0000-0000-0000-000000000018", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-04-01"), Date.parse(@year+"-04-30"), "00000000-0000-0000-0000-000000000018", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-05-01"), Date.parse(@year+"-05-31"), "00000000-0000-0000-0000-000000000018", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-06-01"), Date.parse(@year+"-06-30"), "00000000-0000-0000-0000-000000000018", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-07-01"), Date.parse(@year+"-07-31"), "00000000-0000-0000-0000-000000000018", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-08-01"), Date.parse(@year+"-08-31"), "00000000-0000-0000-0000-000000000018", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-09-01"), Date.parse(@year+"-09-30"), "00000000-0000-0000-0000-000000000018", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-10-01"), Date.parse(@year+"-10-31"), "00000000-0000-0000-0000-000000000018", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-11-01"), Date.parse(@year+"-11-30"), "00000000-0000-0000-0000-000000000018", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-12-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000018", @kg.uuid),
          
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000018", @kg.uuid)
        ]
        #-------------- END - TO NURSERY WH ----------------
        
        
        #-------------- START - YOUNG FRUIT ----------------
        @young_fruit_unit = [
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-01-31"), "00000000-0000-0000-0000-000000000017", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-02-01"), Date.parse(@year+@feb_str), "00000000-0000-0000-0000-000000000017", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-03-01"), Date.parse(@year+"-03-31"), "00000000-0000-0000-0000-000000000017", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-04-01"), Date.parse(@year+"-04-30"), "00000000-0000-0000-0000-000000000017", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-05-01"), Date.parse(@year+"-05-31"), "00000000-0000-0000-0000-000000000017", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-06-01"), Date.parse(@year+"-06-30"), "00000000-0000-0000-0000-000000000017", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-07-01"), Date.parse(@year+"-07-31"), "00000000-0000-0000-0000-000000000017", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-08-01"), Date.parse(@year+"-08-31"), "00000000-0000-0000-0000-000000000017", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-09-01"), Date.parse(@year+"-09-30"), "00000000-0000-0000-0000-000000000017", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-10-01"), Date.parse(@year+"-10-31"), "00000000-0000-0000-0000-000000000017", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-11-01"), Date.parse(@year+"-11-30"), "00000000-0000-0000-0000-000000000017", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-12-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000017", @unit.uuid),
          
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000017", @unit.uuid)
        ]
        @young_fruit_kg = [
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-01-31"), "00000000-0000-0000-0000-000000000017", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-02-01"), Date.parse(@year+@feb_str), "00000000-0000-0000-0000-000000000017", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-03-01"), Date.parse(@year+"-03-31"), "00000000-0000-0000-0000-000000000017", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-04-01"), Date.parse(@year+"-04-30"), "00000000-0000-0000-0000-000000000017", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-05-01"), Date.parse(@year+"-05-31"), "00000000-0000-0000-0000-000000000017", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-06-01"), Date.parse(@year+"-06-30"), "00000000-0000-0000-0000-000000000017", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-07-01"), Date.parse(@year+"-07-31"), "00000000-0000-0000-0000-000000000017", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-08-01"), Date.parse(@year+"-08-31"), "00000000-0000-0000-0000-000000000017", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-09-01"), Date.parse(@year+"-09-30"), "00000000-0000-0000-0000-000000000017", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-10-01"), Date.parse(@year+"-10-31"), "00000000-0000-0000-0000-000000000017", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-11-01"), Date.parse(@year+"-11-30"), "00000000-0000-0000-0000-000000000017", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-12-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000017", @kg.uuid),
          
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000017", @kg.uuid)
        ]
        #-------------- END - YOUNG FRUIT ----------------
        
        
        #-------------- START - SPOILED RIPE ----------------
        @spoiled_ripe_unit = [
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-01-31"), "00000000-0000-0000-0000-000000000016", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-02-01"), Date.parse(@year+@feb_str), "00000000-0000-0000-0000-000000000016", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-03-01"), Date.parse(@year+"-03-31"), "00000000-0000-0000-0000-000000000016", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-04-01"), Date.parse(@year+"-04-30"), "00000000-0000-0000-0000-000000000016", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-05-01"), Date.parse(@year+"-05-31"), "00000000-0000-0000-0000-000000000016", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-06-01"), Date.parse(@year+"-06-30"), "00000000-0000-0000-0000-000000000016", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-07-01"), Date.parse(@year+"-07-31"), "00000000-0000-0000-0000-000000000016", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-08-01"), Date.parse(@year+"-08-31"), "00000000-0000-0000-0000-000000000016", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-09-01"), Date.parse(@year+"-09-30"), "00000000-0000-0000-0000-000000000016", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-10-01"), Date.parse(@year+"-10-31"), "00000000-0000-0000-0000-000000000016", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-11-01"), Date.parse(@year+"-11-30"), "00000000-0000-0000-0000-000000000016", @unit.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-12-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000016", @unit.uuid),
          
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000016", @unit.uuid)
        ]
        @spoiled_ripe_kg = [
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-01-31"), "00000000-0000-0000-0000-000000000016", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-02-01"), Date.parse(@year+@feb_str), "00000000-0000-0000-0000-000000000016", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-03-01"), Date.parse(@year+"-03-31"), "00000000-0000-0000-0000-000000000016", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-04-01"), Date.parse(@year+"-04-30"), "00000000-0000-0000-0000-000000000016", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-05-01"), Date.parse(@year+"-05-31"), "00000000-0000-0000-0000-000000000016", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-06-01"), Date.parse(@year+"-06-30"), "00000000-0000-0000-0000-000000000016", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-07-01"), Date.parse(@year+"-07-31"), "00000000-0000-0000-0000-000000000016", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-08-01"), Date.parse(@year+"-08-31"), "00000000-0000-0000-0000-000000000016", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-09-01"), Date.parse(@year+"-09-30"), "00000000-0000-0000-0000-000000000016", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-10-01"), Date.parse(@year+"-10-31"), "00000000-0000-0000-0000-000000000016", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-11-01"), Date.parse(@year+"-11-30"), "00000000-0000-0000-0000-000000000016", @kg.uuid),
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-12-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000016", @kg.uuid),
          
          OutputTask.sum_output_amount_by_farm(@jackfruit.uuid, @farm.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000016", @kg.uuid)
        ]
        #-------------- END - SPOILED RIPE ----------------
      else
        #----------- START - ACTUAL ------------
        @actual_pdt_unit = [
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-01-31"), "00000000-0000-0000-0000-000000000012", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-02-01"), Date.parse(@year+@feb_str), "00000000-0000-0000-0000-000000000012", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-03-01"), Date.parse(@year+"-03-31"), "00000000-0000-0000-0000-000000000012", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-04-01"), Date.parse(@year+"-04-30"), "00000000-0000-0000-0000-000000000012", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-05-01"), Date.parse(@year+"-05-31"), "00000000-0000-0000-0000-000000000012", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-06-01"), Date.parse(@year+"-06-30"), "00000000-0000-0000-0000-000000000012", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-07-01"), Date.parse(@year+"-07-31"), "00000000-0000-0000-0000-000000000012", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-08-01"), Date.parse(@year+"-08-31"), "00000000-0000-0000-0000-000000000012", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-09-01"), Date.parse(@year+"-09-30"), "00000000-0000-0000-0000-000000000012", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-10-01"), Date.parse(@year+"-10-31"), "00000000-0000-0000-0000-000000000012", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-11-01"), Date.parse(@year+"-11-30"), "00000000-0000-0000-0000-000000000012", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-12-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000012", @unit.uuid),
          
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000012", @unit.uuid)
        ]
        @actual_pdt_kg = [
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-01-31"), "00000000-0000-0000-0000-000000000012", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-02-01"), Date.parse(@year+@feb_str), "00000000-0000-0000-0000-000000000012", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-03-01"), Date.parse(@year+"-03-31"), "00000000-0000-0000-0000-000000000012", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-04-01"), Date.parse(@year+"-04-30"), "00000000-0000-0000-0000-000000000012", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-05-01"), Date.parse(@year+"-05-31"), "00000000-0000-0000-0000-000000000012", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-06-01"), Date.parse(@year+"-06-30"), "00000000-0000-0000-0000-000000000012", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-07-01"), Date.parse(@year+"-07-31"), "00000000-0000-0000-0000-000000000012", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-08-01"), Date.parse(@year+"-08-31"), "00000000-0000-0000-0000-000000000012", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-09-01"), Date.parse(@year+"-09-30"), "00000000-0000-0000-0000-000000000012", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-10-01"), Date.parse(@year+"-10-31"), "00000000-0000-0000-0000-000000000012", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-11-01"), Date.parse(@year+"-11-30"), "00000000-0000-0000-0000-000000000012", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-12-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000012", @kg.uuid),
          
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000012", @kg.uuid)
        ]
        #------------- END - ACTUAL ------------
        
        
        #-------------- START - TO FINISH WH ----------------
        @to_finish_wh_unit = [
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-01-31"), "00000000-0000-0000-0000-000000000019", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-02-01"), Date.parse(@year+@feb_str), "00000000-0000-0000-0000-000000000019", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-03-01"), Date.parse(@year+"-03-31"), "00000000-0000-0000-0000-000000000019", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-04-01"), Date.parse(@year+"-04-30"), "00000000-0000-0000-0000-000000000019", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-05-01"), Date.parse(@year+"-05-31"), "00000000-0000-0000-0000-000000000019", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-06-01"), Date.parse(@year+"-06-30"), "00000000-0000-0000-0000-000000000019", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-07-01"), Date.parse(@year+"-07-31"), "00000000-0000-0000-0000-000000000019", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-08-01"), Date.parse(@year+"-08-31"), "00000000-0000-0000-0000-000000000019", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-09-01"), Date.parse(@year+"-09-30"), "00000000-0000-0000-0000-000000000019", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-10-01"), Date.parse(@year+"-10-31"), "00000000-0000-0000-0000-000000000019", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-11-01"), Date.parse(@year+"-11-30"), "00000000-0000-0000-0000-000000000019", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-12-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000019", @unit.uuid),
          
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000019", @unit.uuid)
        ]
        @to_finish_wh_kg = [
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-01-31"), "00000000-0000-0000-0000-000000000019", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-02-01"), Date.parse(@year+@feb_str), "00000000-0000-0000-0000-000000000019", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-03-01"), Date.parse(@year+"-03-31"), "00000000-0000-0000-0000-000000000019", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-04-01"), Date.parse(@year+"-04-30"), "00000000-0000-0000-0000-000000000019", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-05-01"), Date.parse(@year+"-05-31"), "00000000-0000-0000-0000-000000000019", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-06-01"), Date.parse(@year+"-06-30"), "00000000-0000-0000-0000-000000000019", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-07-01"), Date.parse(@year+"-07-31"), "00000000-0000-0000-0000-000000000019", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-08-01"), Date.parse(@year+"-08-31"), "00000000-0000-0000-0000-000000000019", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-09-01"), Date.parse(@year+"-09-30"), "00000000-0000-0000-0000-000000000019", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-10-01"), Date.parse(@year+"-10-31"), "00000000-0000-0000-0000-000000000019", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-11-01"), Date.parse(@year+"-11-30"), "00000000-0000-0000-0000-000000000019", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-12-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000019", @kg.uuid),
          
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000019", @kg.uuid)
        ]
        #-------------- END - TO FINISH WH ----------------
        
        
        #-------------- START - TO NURSERY WH ----------------
        @to_nursery_wh_unit = [
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-01-31"), "00000000-0000-0000-0000-000000000018", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-02-01"), Date.parse(@year+@feb_str), "00000000-0000-0000-0000-000000000018", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-03-01"), Date.parse(@year+"-03-31"), "00000000-0000-0000-0000-000000000018", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-04-01"), Date.parse(@year+"-04-30"), "00000000-0000-0000-0000-000000000018", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-05-01"), Date.parse(@year+"-05-31"), "00000000-0000-0000-0000-000000000018", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-06-01"), Date.parse(@year+"-06-30"), "00000000-0000-0000-0000-000000000018", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-07-01"), Date.parse(@year+"-07-31"), "00000000-0000-0000-0000-000000000018", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-08-01"), Date.parse(@year+"-08-31"), "00000000-0000-0000-0000-000000000018", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-09-01"), Date.parse(@year+"-09-30"), "00000000-0000-0000-0000-000000000018", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-10-01"), Date.parse(@year+"-10-31"), "00000000-0000-0000-0000-000000000018", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-11-01"), Date.parse(@year+"-11-30"), "00000000-0000-0000-0000-000000000018", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-12-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000018", @unit.uuid),
          
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000018", @unit.uuid)
        ]
        @to_nursery_wh_kg = [
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-01-31"), "00000000-0000-0000-0000-000000000018", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-02-01"), Date.parse(@year+@feb_str), "00000000-0000-0000-0000-000000000018", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-03-01"), Date.parse(@year+"-03-31"), "00000000-0000-0000-0000-000000000018", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-04-01"), Date.parse(@year+"-04-30"), "00000000-0000-0000-0000-000000000018", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-05-01"), Date.parse(@year+"-05-31"), "00000000-0000-0000-0000-000000000018", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-06-01"), Date.parse(@year+"-06-30"), "00000000-0000-0000-0000-000000000018", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-07-01"), Date.parse(@year+"-07-31"), "00000000-0000-0000-0000-000000000018", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-08-01"), Date.parse(@year+"-08-31"), "00000000-0000-0000-0000-000000000018", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-09-01"), Date.parse(@year+"-09-30"), "00000000-0000-0000-0000-000000000018", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-10-01"), Date.parse(@year+"-10-31"), "00000000-0000-0000-0000-000000000018", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-11-01"), Date.parse(@year+"-11-30"), "00000000-0000-0000-0000-000000000018", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-12-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000018", @kg.uuid),
          
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000018", @kg.uuid)
        ]
        #-------------- END - TO NURSERY WH ----------------
        
        
        #-------------- START - YOUNG FRUIT ----------------
        @young_fruit_unit = [
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-01-31"), "00000000-0000-0000-0000-000000000017", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-02-01"), Date.parse(@year+@feb_str), "00000000-0000-0000-0000-000000000017", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-03-01"), Date.parse(@year+"-03-31"), "00000000-0000-0000-0000-000000000017", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-04-01"), Date.parse(@year+"-04-30"), "00000000-0000-0000-0000-000000000017", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-05-01"), Date.parse(@year+"-05-31"), "00000000-0000-0000-0000-000000000017", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-06-01"), Date.parse(@year+"-06-30"), "00000000-0000-0000-0000-000000000017", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-07-01"), Date.parse(@year+"-07-31"), "00000000-0000-0000-0000-000000000017", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-08-01"), Date.parse(@year+"-08-31"), "00000000-0000-0000-0000-000000000017", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-09-01"), Date.parse(@year+"-09-30"), "00000000-0000-0000-0000-000000000017", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-10-01"), Date.parse(@year+"-10-31"), "00000000-0000-0000-0000-000000000017", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-11-01"), Date.parse(@year+"-11-30"), "00000000-0000-0000-0000-000000000017", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-12-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000017", @unit.uuid),
          
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000017", @unit.uuid)
        ]
        @young_fruit_kg = [
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-01-31"), "00000000-0000-0000-0000-000000000017", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-02-01"), Date.parse(@year+@feb_str), "00000000-0000-0000-0000-000000000017", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-03-01"), Date.parse(@year+"-03-31"), "00000000-0000-0000-0000-000000000017", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-04-01"), Date.parse(@year+"-04-30"), "00000000-0000-0000-0000-000000000017", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-05-01"), Date.parse(@year+"-05-31"), "00000000-0000-0000-0000-000000000017", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-06-01"), Date.parse(@year+"-06-30"), "00000000-0000-0000-0000-000000000017", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-07-01"), Date.parse(@year+"-07-31"), "00000000-0000-0000-0000-000000000017", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-08-01"), Date.parse(@year+"-08-31"), "00000000-0000-0000-0000-000000000017", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-09-01"), Date.parse(@year+"-09-30"), "00000000-0000-0000-0000-000000000017", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-10-01"), Date.parse(@year+"-10-31"), "00000000-0000-0000-0000-000000000017", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-11-01"), Date.parse(@year+"-11-30"), "00000000-0000-0000-0000-000000000017", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-12-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000017", @kg.uuid),
          
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000017", @kg.uuid)
        ]
        #-------------- END - YOUNG FRUIT ----------------
        
        
        #-------------- START - SPOILED RIPE ----------------
        @spoiled_ripe_unit = [
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-01-31"), "00000000-0000-0000-0000-000000000016", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-02-01"), Date.parse(@year+@feb_str), "00000000-0000-0000-0000-000000000016", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-03-01"), Date.parse(@year+"-03-31"), "00000000-0000-0000-0000-000000000016", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-04-01"), Date.parse(@year+"-04-30"), "00000000-0000-0000-0000-000000000016", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-05-01"), Date.parse(@year+"-05-31"), "00000000-0000-0000-0000-000000000016", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-06-01"), Date.parse(@year+"-06-30"), "00000000-0000-0000-0000-000000000016", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-07-01"), Date.parse(@year+"-07-31"), "00000000-0000-0000-0000-000000000016", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-08-01"), Date.parse(@year+"-08-31"), "00000000-0000-0000-0000-000000000016", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-09-01"), Date.parse(@year+"-09-30"), "00000000-0000-0000-0000-000000000016", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-10-01"), Date.parse(@year+"-10-31"), "00000000-0000-0000-0000-000000000016", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-11-01"), Date.parse(@year+"-11-30"), "00000000-0000-0000-0000-000000000016", @unit.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-12-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000016", @unit.uuid),
          
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000016", @unit.uuid)
        ]
        @spoiled_ripe_kg = [
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-01-31"), "00000000-0000-0000-0000-000000000016", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-02-01"), Date.parse(@year+@feb_str), "00000000-0000-0000-0000-000000000016", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-03-01"), Date.parse(@year+"-03-31"), "00000000-0000-0000-0000-000000000016", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-04-01"), Date.parse(@year+"-04-30"), "00000000-0000-0000-0000-000000000016", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-05-01"), Date.parse(@year+"-05-31"), "00000000-0000-0000-0000-000000000016", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-06-01"), Date.parse(@year+"-06-30"), "00000000-0000-0000-0000-000000000016", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-07-01"), Date.parse(@year+"-07-31"), "00000000-0000-0000-0000-000000000016", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-08-01"), Date.parse(@year+"-08-31"), "00000000-0000-0000-0000-000000000016", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-09-01"), Date.parse(@year+"-09-30"), "00000000-0000-0000-0000-000000000016", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-10-01"), Date.parse(@year+"-10-31"), "00000000-0000-0000-0000-000000000016", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-11-01"), Date.parse(@year+"-11-30"), "00000000-0000-0000-0000-000000000016", @kg.uuid),
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-12-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000016", @kg.uuid),
          
          OutputTask.grand_total_output_amount(@jackfruit.uuid, Date.parse(@year+"-01-01"), Date.parse(@year+"-12-31"), "00000000-0000-0000-0000-000000000016", @kg.uuid)
        ]
        #-------------- END - SPOILED RIPE ----------------
      end
    end
  end
end
