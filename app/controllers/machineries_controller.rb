class MachineriesController < ApplicationController
  authorize_resource :class => false

  add_breadcrumb "All Machineries", :machineries_path
  
  def index
    begin
      @tractors = Tractor.all
      @implements = Implement.all
      @maintenances = MaintenanceDecorator.new(Maintenance.all)
    rescue Exception => e
      puts e
    end
  end
end
