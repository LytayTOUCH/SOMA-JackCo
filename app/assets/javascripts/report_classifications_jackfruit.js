$(document).ready(function() {
  $('#print_button').click(function() { window.print(); });
});

google.load('visualization', '1', {packages: ['corechart', 'line']});
google.setOnLoadCallback(drawBasic);

var year = $("#year").val() == undefined? "" : $("#year").val();

var standard_pdt = JSON.parse($("#standard_pdt").val() == undefined? "[0,0,0,0,0,0,0,0,0,0,0,0]" : $("#standard_pdt").val());
var forecast_pdt = JSON.parse($("#forecast_pdt").val() == undefined? "[0,0,0,0,0,0,0,0,0,0,0,0]" : $("#forecast_pdt").val());
var actual_pdt = JSON.parse($("#actual_pdt").val() == undefined? "[0,0,0,0,0,0,0,0,0,0,0,0]" : $("#actual_pdt").val());
var to_finish_wh = JSON.parse($("#to_finish_wh").val() == undefined? "[0,0,0,0,0,0,0,0,0,0,0,0]" : $("#to_finish_wh").val());
var to_nursery_wh = JSON.parse($("#to_nursery_wh").val() == undefined? "[0,0,0,0,0,0,0,0,0,0,0,0]" : $("#to_nursery_wh").val());
var young_fruit = JSON.parse($("#young_fruit").val() == undefined? "[0,0,0,0,0,0,0,0,0,0,0,0]" : $("#young_fruit").val());
var spoiled_ripe = JSON.parse($("#spoiled_ripe").val() == undefined? "[0,0,0,0,0,0,0,0,0,0,0,0]" : $("#spoiled_ripe").val());
    
function drawBasic() {
  var data = new google.visualization.DataTable();
  data.addColumn('string', 'X');
  data.addColumn('number', 'Standard PDT');
  data.addColumn('number', 'Forecast PDT');
  data.addColumn('number', 'Actual PDT');
  data.addColumn('number', 'To Finish WH');
  data.addColumn('number', 'To Nursery WH');
  data.addColumn('number', 'Young Fruit');
  data.addColumn('number', 'Spoiled Ripe');
    
  data.addRows([
    ["Jan-"+year, standard_pdt[0],  forecast_pdt[0],  actual_pdt[0],  to_finish_wh[0],  to_nursery_wh[0],  young_fruit[0],  spoiled_ripe[0]],
    ["Feb-"+year, standard_pdt[1],  forecast_pdt[1],  actual_pdt[1],  to_finish_wh[1],  to_nursery_wh[1],  young_fruit[1],  spoiled_ripe[1]],
    ["Mar-"+year, standard_pdt[2],  forecast_pdt[2],  actual_pdt[2],  to_finish_wh[2],  to_nursery_wh[2],  young_fruit[2],  spoiled_ripe[2]],
    ["Apr-"+year, standard_pdt[3],  forecast_pdt[3],  actual_pdt[3],  to_finish_wh[3],  to_nursery_wh[3],  young_fruit[3],  spoiled_ripe[3]],
    ["May-"+year, standard_pdt[4],  forecast_pdt[4],  actual_pdt[4],  to_finish_wh[4],  to_nursery_wh[4],  young_fruit[4],  spoiled_ripe[4]],
    ["Jun-"+year, standard_pdt[5],  forecast_pdt[5],  actual_pdt[5],  to_finish_wh[5],  to_nursery_wh[5],  young_fruit[5],  spoiled_ripe[5]],
    ["Jul-"+year, standard_pdt[6],  forecast_pdt[6],  actual_pdt[6],  to_finish_wh[6],  to_nursery_wh[6],  young_fruit[6],  spoiled_ripe[6]],
    ["Aug-"+year, standard_pdt[7],  forecast_pdt[7],  actual_pdt[7],  to_finish_wh[7],  to_nursery_wh[7],  young_fruit[7],  spoiled_ripe[7]],
    ["Sep-"+year, standard_pdt[8],  forecast_pdt[8],  actual_pdt[8],  to_finish_wh[8],  to_nursery_wh[8],  young_fruit[8],  spoiled_ripe[8]],
    ["Oct-"+year, standard_pdt[9],  forecast_pdt[9],  actual_pdt[9],  to_finish_wh[9],  to_nursery_wh[9],  young_fruit[9],  spoiled_ripe[9]],
    ["Nov-"+year, standard_pdt[10], forecast_pdt[10], actual_pdt[10], to_finish_wh[10], to_nursery_wh[10], young_fruit[10], spoiled_ripe[10]],
    ["Dec-"+year, standard_pdt[11], forecast_pdt[11], actual_pdt[11], to_finish_wh[11], to_nursery_wh[11], young_fruit[11], spoiled_ripe[11]]
  ]);
   
  var options = {
    hAxis: {
      title: 'Period'
    },
    vAxis: {
      title: 'Production'
    },
    colors:['#3333FF','#852314', '#55DD33', '#5A287D', '#FF9600', '#1EA6A3', '#FF0055']
  };
    
  var chart = new google.visualization.LineChart(document.getElementById('jackfruit_classification_chart'));
    
  chart.draw(data, options);
}