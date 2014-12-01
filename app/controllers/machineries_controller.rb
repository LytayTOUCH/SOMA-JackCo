class MachineriesController < ApplicationController
  def index
    @tractors = Tractor.all
    @implements = Implement.all
    @maintenances = MaintenanceDecorator.new(Maintenance.all)
  end
end
