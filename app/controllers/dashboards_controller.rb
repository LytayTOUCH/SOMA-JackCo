class DashboardsController < ApplicationController
  respond_to :html, :json

  def index

  end

  def getBarData
    @bar_chart_data = TestingWithBarChart.pluck(:element, :amount, :bar_color)
    respond_with do |format|
      format.json {render :json => @bar_chart_data}
    end            
  end
  
  def getPieData
    @pie_chart_data = TestingChart.pluck(:name, :amount)
    respond_with do |format|
      format.json {render :json => @pie_chart_data}
    end
  end
end