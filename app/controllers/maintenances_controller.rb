class MaintenancesController < ApplicationController
  def new
    @maintenance = Maintenance.new
    @labor = Labor.all
    @default_labor = Labor.first
  end
end
