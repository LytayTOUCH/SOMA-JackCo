class DashboardsController < ApplicationController
  respond_to :html, :json
  def index

    data = [['1997',10],['1998',20],['1999',40]]

    @labels = TestingChart.pluck(:name, :amount)
    
    # @labels =[
    #   ["Officer", 5],
    #   ["IT Admin", 6],
    #   ["Cleaner", 3],
    #   ["Guard", 7],
    #   ["Cook", 15],
    #   ["Table Runner", 25],
    #   ["Table Washer", 65]
    # ]
    respond_with do |format|
      format.json {render :json => @labels}
    end

    @line_chart = Gchart.pie(data: [60,30,50], title: 'Line chart', labels: @labels, size: '400x300')

    # data = [
    #   {
    #     name: "Fantasy & Sci Fi", 
    #     data: [["2010", "10"], ["2020", "16"], ["2030", "28"]]
    #   },
    #   {
    #     name: "Romance", 
    #     data: [["2010", "24"], ["2020", "22"], ["2030", "19"]]
    #   },
    #   {
    #     name: "Mystery/Crime", 
    #     data: [["2010", "20"], ["2020", "23"], ["2030", "29"]]
    #   }
    # ]

    data1 = [20, 60, 30]

    @bar_chart = Gchart.bar(data: data1, bar_width_and_spacing: '35,20', title: 'Bar chart', labels: ["January", "Feburary", "March"], legend: ['courbe 1','courbe 2','courbe 3'], axis_with_label: ['J', 'F', 'M'], width: '500')
  end
end