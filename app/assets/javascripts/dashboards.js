var pieData;
var barData;
$(document).ready(function() {
	
  $("td.temp").each(function(){
  	var uuid = $(this).attr("id");
  	var latlong = $(this).attr("latlong").split(", ");
  	
  	$.ajax({
	  	url: 'http://api.openweathermap.org/data/2.5/weather?lat='+ latlong[0] +'&lon='+ latlong[1] +'&units=metric',
	  	dataType: 'json',
	  	success: function(data){
	  	  $("#"+uuid).append(data.main.temp + " <sup>o</sup>C");
	  	}
	  });
  });
	
  // ======================= Pie Chart ======================
  $.ajax({
    url:'dashboards/getPieData.json',
    dataType: 'json',
    success: function(pdata){
      pieData = pdata;

      google.load('visualization', '1.0', {'packages':['corechart']});

      var data = new google.visualization.DataTable();
    
      data.addColumn('string', 'Topping');
      data.addColumn('number', 'Slices');
      data.addRows(pieData);
      
      var options = {'title':'Expense',
                     // 'width': 420,
                     // 'height': 195,
                   'colors': ['blue', 'red', 'orange', 'green', 'pink', 'yellow', 'gray', 'Purple', 'Gold', 'Lime', 'Olive', 'Cyan']
                 };

      var chartpie = new google.visualization.PieChart(document.getElementById('chart_div'));
      chartpie.draw(data, options);
    }
  });

  // ======================= Bar Chart ======================
  $.ajax({
    url:'dashboards/getBarData.json',
    dataType: 'json',
    success: function(bdata){
      bdata.unshift(["Element", "Expense", { role: "style" }]);
      barData = bdata;

      google.load('visualization', '1.0', {'packages':['corechart']});

       
      var data_bar = google.visualization.arrayToDataTable(barData);
      var view = new google.visualization.DataView(data_bar);
      view.setColumns([0, 1,
                       { calc: "stringify",
                         sourceColumn: 1,
                         type: "string",
                         role: "annotation" },
                       2]);

      var options = {
        title: "Production Yield 2015",
        // width: 420,
        // height: 195,
        bar: {groupWidth: "95%"},
        legend: { position: "none" },
      };
      var chart = new google.visualization.ColumnChart(document.getElementById("columnchart_values"));
      chart.draw(view, options);
    }
  });
});  

google.load('visualization', '1.0', {'packages':['corechart']});

google.setOnLoadCallback(drawChart);

function drawChart() {

  // ======================= Line Chart ======================
  var data_line = google.visualization.arrayToDataTable([
    ['Year', 'Sales', 'Expenses', 'Investment'],
    ['2004',  1000, 400, 300],
    ['2005',  1170, 460, 500],
    ['2006',  660, 1120, 550],
    ['2007',  1030, 540, 700]
  ]);

  var line_chart = new google.visualization.LineChart(document.getElementById('curve_line_chart'));

 var line_options = {
        title: 'Company Performance',
        curveType: 'function',
        legend: { position: 'bottom' }
      };

  line_chart.draw(data_line, line_options);
}