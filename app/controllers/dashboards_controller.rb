require 'date'

class DashboardsController < ApplicationController
  respond_to :html, :json

  def index
    @year = Date.today.strftime("%Y")
    @farms=Farm.all
    @planting_projects = PlantingProject.all
    
    coconut = PlantingProject.find_by_name("Coconut")
    jackfruit = PlantingProject.find_by_name("Jackfruit")
    @project_distributions = [
      [coconut.uuid,"00000000-0000-0000-0000-000000000001","Coconut"],
      [jackfruit.uuid,"00000000-0000-0000-0000-000000000012","Jackfruit"]
    ]
     
    @unit = UnitOfMeasurement.find_by_name("Unit")
  end
end