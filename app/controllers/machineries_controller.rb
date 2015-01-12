class MachineriesController < ApplicationController
  authorize_resource :class => false
  
  def index
    @tractors = Tractor.all
    @implements = Implement.all
    @maintenances = MaintenanceDecorator.new(Maintenance.all)
  end
end
