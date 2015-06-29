class ReportNurseriesController < ApplicationController
  def coconut_index
    if !params[:filter].nil? && !params[:filter][:day].nil?
      if params[:filter][:day] == "today"
        start_date = Date.today
        end_date = Date.today
      elsif params[:filter][:day] == "week"
        start_date = Date.today.beginning_of_week
        end_date = Date.today.end_of_week
      elsif params[:filter][:day] == "month"
        start_date = Date.today.beginning_of_month
        end_date = Date.today.end_of_month
      elsif params[:filter][:day] == "year"
        start_date = Date.today.beginning_of_year
        end_date = Date.today.end_of_year
      else
        start_date = Date.strptime(params[:filter][:start_date], "%Y-%m-%d")
        end_date = Date.strptime(params[:filter][:end_date], "%Y-%m-%d")
      end
      
      @cs = CoconutNurseryInput.where(:warehouse_id => params[:filter][:warehouse_id], :nursery_date => start_date.beginning_of_day..end_date.end_of_day)
    end
  end
end
