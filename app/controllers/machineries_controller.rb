class MachineriesController < ApplicationController
  def index
    @tractors = Tractor.all
    @implements = Implement.all
    @maintenances = Maintenance.all
  end
end
