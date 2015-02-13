class UnitOfMeasurementController < ApplicationController
  def index
  	begin
      @unit_of_measurement = UnitOfMeasurement.new

      if params[:unit_of_measurement] and params[:unit_of_measurement][:name] and !params[:unit_of_measurement][:name].nil?
        
        @unit_of_measurements = UnitOfMeasurement.find_by_name(params[:unit_of_measurement][:name]).page(params[:page]).per(5)        
      else
        @unit_of_measurements = UnitOfMeasurement.page(params[:page]).per(5)       
      end
    rescue Exception => e
      puts e
    end
  end

end
