class DashboardsController < ApplicationController
  def index
    @line_chart = Gchart.line(:data => [0, 40, 10, 70, 20])
  end
end