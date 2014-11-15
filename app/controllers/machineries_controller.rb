class MachineriesController < ApplicationController
  def new_tractor
    flash[:notice] = "Hello"
    redirect_to dashboards_path
  end
end
