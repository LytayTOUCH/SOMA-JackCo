class DashboardsController < ApplicationController
  respond_to :html, :json

  def index
    @farms=Farm.all
    @planting_projects = PlantingProject.all
    @input_tasks = InputTask.order('created_at DESC')
  end
end