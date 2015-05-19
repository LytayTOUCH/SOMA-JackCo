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
});

google.load('visualization', '1', {packages: ['corechart', 'bar']});
$('#parent_chart_div > div').each(function () {
  var id = this.id;
  var child_div = $("#"+id);
  var standard = child_div.find("input").eq(0).val();
  var forecast = child_div.find("input").eq(1).val();
  var actual = child_div.find("input").eq(2).val();
  var title = child_div.find("input").eq(3).val();
  
  google.setOnLoadCallback(function(){ drawStacked(id,title,["", parseInt(standard), parseInt(forecast), parseInt(actual)]); });
});

function drawStacked(div_name, title, values) {
  var data = new google.visualization.DataTable();
  data.addColumn('string', 'X');
  data.addColumn('number', 'Standard Production');
  data.addColumn('number', 'Forecast Production');
  data.addColumn('number', 'Actual Production');

  data.addRows([
    values
  ]);

  var options = {
    title: title,
    legend: {position: 'none'},
    vAxis: {
      title: 'Production'
    },
    colors:['#3333FF','#852314', '#55DD33']
  };

  var chart = new google.visualization.ColumnChart(document.getElementById(div_name));
  chart.draw(data, options);
}
