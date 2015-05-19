class DashboardsController < ApplicationController
  respond_to :html, :json

  def index
    @farms=Farm.all
    @planting_projects = PlantingProject.all
  end
end