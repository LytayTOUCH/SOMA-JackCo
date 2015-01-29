class DashboardsController < ApplicationController
  respond_to :html, :json
  def index

    data = [['1997',10],['1998',20],['1999',40]]

    @labels = TestingChart.pluck(:name, :amount)
    
    respond_with do |format|
      format.json {render :json => @labels}
    end

    @line_chart = Gchart.pie(data: [60,30,50], title: 'Line chart', labels: @labels, size: '400x300')

    data1 = [20, 60, 30]

    @bar_chart = Gchart.bar(data: data1, bar_width_and_spacing: '35,20', title: 'Bar chart', labels: ["January", "Feburary", "March"], legend: ['courbe 1','courbe 2','courbe 3'], axis_with_label: ['J', 'F', 'M'], width: '500')
  end
end