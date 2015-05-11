class ReportProductivitiesController < ApplicationController
  def coconut_index
    if !params[:filter].nil? && params[:filter][:farm_id]!="g_total"
      @farm = Farm.find_by_uuid(params[:filter][:farm_id])
    end
  end

  def jackfruit_index
  end
end
