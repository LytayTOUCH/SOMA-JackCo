google.load('visualization', '1', {packages: ['corechart', 'line']});
google.setOnLoadCallback(drawBasic);

var standard_pdt = JSON.parse($("#standard_pdt").val() == undefined? "[0,0,0,0,0,0,0,0,0,0,0,0]" : $("#standard_pdt").val());
var forecast_pdt = JSON.parse($("#forecast_pdt").val() == undefined? "[0,0,0,0,0,0,0,0,0,0,0,0]" : $("#forecast_pdt").val());
var actual_pdt = JSON.parse($("#actual_pdt").val() == undefined? "[0,0,0,0,0,0,0,0,0,0,0,0]" : $("#actual_pdt").val());
var to_finish_wh = JSON.parse($("#to_finish_wh").val() == undefined? "[0,0,0,0,0,0,0,0,0,0,0,0]" : $("#to_finish_wh").val());
var to_nursery_wh = JSON.parse($("#to_nursery_wh").val() == undefined? "[0,0,0,0,0,0,0,0,0,0,0,0]" : $("#to_nursery_wh").val());
var spoiled = JSON.parse($("#spoiled").val() == undefined? "[0,0,0,0,0,0,0,0,0,0,0,0]" : $("#spoiled").val());
var free_at_farm = JSON.parse($("#free_at_farm").val() == undefined? "[0,0,0,0,0,0,0,0,0,0,0,0]" : $("#free_at_farm").val());

function drawBasic() {
  var data = new google.visualization.DataTable();
  data.addColumn('string', 'X');
  data.addColumn('number', 'Standard PDT');
  data.addColumn('number', 'Forecast PDT');
  data.addColumn('number', 'Actual PDT');
  data.addColumn('number', 'To Finish WH');
  data.addColumn('number', 'To Nursery WH');
  data.addColumn('number', 'Spoiled');
  data.addColumn('number', 'Free at Farm');

  data.addRows([
    ["Jan-15", standard_pdt[0],  forecast_pdt[0],  actual_pdt[0],  to_finish_wh[0],  to_nursery_wh[0],  spoiled[0],  free_at_farm[0]],
    ["Feb-15", standard_pdt[1],  forecast_pdt[1],  actual_pdt[1],  to_finish_wh[1],  to_nursery_wh[1],  spoiled[1],  free_at_farm[1]],
    ["Mar-15", standard_pdt[2],  forecast_pdt[2],  actual_pdt[2],  to_finish_wh[2],  to_nursery_wh[2],  spoiled[2],  free_at_farm[2]],
    ["Apr-15", standard_pdt[3],  forecast_pdt[3],  actual_pdt[3],  to_finish_wh[3],  to_nursery_wh[3],  spoiled[3],  free_at_farm[3]],
    ["May-15", standard_pdt[4],  forecast_pdt[4],  actual_pdt[4],  to_finish_wh[4],  to_nursery_wh[4],  spoiled[4],  free_at_farm[4]],
    ["Jun-15", standard_pdt[5],  forecast_pdt[5],  actual_pdt[5],  to_finish_wh[5],  to_nursery_wh[5],  spoiled[5],  free_at_farm[5]],
    ["Jul-15", standard_pdt[6],  forecast_pdt[6],  actual_pdt[6],  to_finish_wh[6],  to_nursery_wh[6],  spoiled[6],  free_at_farm[6]],
    ["Aug-15", standard_pdt[7],  forecast_pdt[7],  actual_pdt[7],  to_finish_wh[7],  to_nursery_wh[7],  spoiled[7],  free_at_farm[7]],
    ["Sep-15", standard_pdt[8],  forecast_pdt[8],  actual_pdt[8],  to_finish_wh[8],  to_nursery_wh[8],  spoiled[8],  free_at_farm[8]],
    ["Oct-15", standard_pdt[9],  forecast_pdt[9],  actual_pdt[9],  to_finish_wh[9],  to_nursery_wh[9],  spoiled[9],  free_at_farm[9]],
    ["Nov-15", standard_pdt[10], forecast_pdt[10], actual_pdt[10], to_finish_wh[10], to_nursery_wh[10], spoiled[10], free_at_farm[10]],
    ["Dec-15", standard_pdt[11], forecast_pdt[11], actual_pdt[11], to_finish_wh[11], to_nursery_wh[11], spoiled[11], free_at_farm[11]]
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

  var chart = new google.visualization.LineChart(document.getElementById('coconut_classification_chart'));

  chart.draw(data, options);
}