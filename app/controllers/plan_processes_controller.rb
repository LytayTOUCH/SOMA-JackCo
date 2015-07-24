class PlanProcessesController < ApplicationController
  def index
    if !params[:filter].nil? && params[:filter][:year]!=""
      @year = params[:filter][:year]
    end
  end
end
