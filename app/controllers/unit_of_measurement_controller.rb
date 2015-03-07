class UnitOfMeasurementController < ApplicationController
  def index
  	begin
      @unit_of_measurement = UnitOfMeasurement.new

      if params[:unit_of_measurement] and params[:unit_of_measurement][:name] and !params[:unit_of_measurement][:name].nil?
        
        @unit_of_measurements = UnitOfMeasurement.find_by_unit_of_measurement_name(params[:unit_of_measurement][:name]).page(params[:page]).per(session[:item_per_page])        
      else
        @unit_of_measurements = UnitOfMeasurement.page(params[:page]).per(session[:item_per_page])       
      end
    rescue Exception => e
      puts e
    end
  end

end
