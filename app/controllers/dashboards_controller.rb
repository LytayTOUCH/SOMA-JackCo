class DashboardsController < ApplicationController
  def index
    @line_chart = Gchart.pie(:data => [20, 10,40], :labels => "Pie Chart", :size => '300x300')

    data = [
      {
        name: "Fantasy & Sci Fi", 
        data: [["2010", "10"], ["2020", "16"], ["2030", "28"]]
      },
      {
        name: "Romance", 
        data: [["2010", "24"], ["2020", "22"], ["2030", "19"]]
      },
      {
        name: "Mystery/Crime", 
        data: [["2010", "20"], ["2020", "23"], ["2030", "29"]]
      }
    ]

    # data = [
    #   ['Year', 'Sales', 'Expenses'],
    #   ['2004',  1000,      400],
    #   ['2005',  1170,      460],
    #   ['2006',  660,       1120],
    #   ['2007',  1030,      540]
    # ]  

    @bar_chart = Gchart.bar(:data => [20,30,80,60], :bar_width_and_spacing => '25,6')
  end
end