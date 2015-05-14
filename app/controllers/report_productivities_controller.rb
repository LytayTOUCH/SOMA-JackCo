require 'date'

class ReportProductivitiesController < ApplicationController
  def coconut_index
    @coconut = PlantingProject.find_by_name("Coconut")
    @unit = UnitOfMeasurement.find_by_name("Unit")
    
    if !params[:filter].nil? && params[:filter][:farm_id]!="g_total"
      @farm = Farm.find_by_uuid(params[:filter][:farm_id])
    end
    
    if !params[:filter].nil? && !params[:filter][:day].nil?
      if params[:filter][:day] == "today"
        @start_date = Date.today
        @end_date = Date.today
      elsif params[:filter][:day] == "week"
        @start_date = Date.today.beginning_of_week
        @end_date = Date.today.end_of_week
      elsif params[:filter][:day] == "month"
        @start_date = Date.today.beginning_of_month
        @end_date = Date.today.end_of_month
      elsif params[:filter][:day] == "year"
        @start_date = Date.today.beginning_of_year
        @end_date = Date.today.end_of_year
      else
        @start_date = Date.strptime(params[:filter][:start_date], "%Y-%m-%d")
        @end_date = Date.strptime(params[:filter][:end_date], "%Y-%m-%d")
      end
    end
  end

  def jackfruit_index
    @jackfruit = PlantingProject.find_by_name("Jackfruit")
    @unit = UnitOfMeasurement.find_by_name("Unit")
    @kg = UnitOfMeasurement.find_by_name("Kg")
    
    if !params[:filter].nil? && params[:filter][:farm_id]!="g_total"
      @farm = Farm.find_by_uuid(params[:filter][:farm_id])
    end
    
    if !params[:filter].nil? && !params[:filter][:day].nil?
      if params[:filter][:day] == "today"
        @start_date = Date.today
        @end_date = Date.today
      elsif params[:filter][:day] == "week"
        @start_date = Date.today.beginning_of_week
        @end_date = Date.today.end_of_week
      elsif params[:filter][:day] == "month"
        @start_date = Date.today.beginning_of_month
        @end_date = Date.today.end_of_month
      elsif params[:filter][:day] == "year"
        @start_date = Date.today.beginning_of_year
        @end_date = Date.today.end_of_year
      else
        @start_date = Date.strptime(params[:filter][:start_date], "%Y-%m-%d")
        @end_date = Date.strptime(params[:filter][:end_date], "%Y-%m-%d")
      end
    end
  end
end
