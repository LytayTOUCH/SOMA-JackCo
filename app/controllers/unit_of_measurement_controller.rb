class UnitOfMeasurementController < ApplicationController
  def index
  	begin
      @unit_measure = UnitOfMeasurement.new

      if params[:unit_measure] and params[:unit_measure][:name] and !params[:unit_measure][:name].nil?
        @unit_measurement = UnitOfMeasurement.find_by_name(params[:unit_measure][:name]).page(params[:page]).per(5)
      else
        @unit_measurement = UnitOfMeasurement.page(params[:page]).per(5)
      end
    rescue Exception => e
      puts e
    end
  end

end
