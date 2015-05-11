$(document).ready(function() {
  $('#production-plan-report-picker').datetimepicker({viewMode: 'years', format: 'YYYY'});

  $('#print-plan-report a#print_preview').click(function() { window.print(); });
});

google.load("visualization", "1.1", {packages:["bar"]});
google.setOnLoadCallback(drawStuff);

function drawStuff() {
  var planting_project_id = $("#id").val();
  var planting_project_name = $("#id option:selected").text();
  var for_year = $("#for_year").val();
  
  jQuery.ajax({
    url: "/get_production_plan_tree",
    type: "GET",
    data: { "id" : planting_project_id,
            "for_year" : for_year },
    dataType: "json",
    success: function(data) {
      if (data){
        var data = new google.visualization.arrayToDataTable([
          ['Move', 'Amount'],
          ["Jan-15", data.jan],
          ["Feb-15", data.feb],
          ["Mar-15", data.mar],
          ["Apr-15", data.apr],
          ["May-15", data.may],
          ["Jun-15", data.jun],
          ["Jul-15", data.jul],
          ["Aug-15", data.aug],
          ["Sep-15", data.sep],
          ["Oct-15", data.oct],
          ["Nov-15", data.nov],
          ["Dec-15", data.dec]
        ]);

        var options = {
          title: planting_project_name + '-Production Forecast-' + for_year,
          width: 1050,
          legend: { position: 'none' },
          chart: { subtitle: 'Forecast-' + for_year },
          axes: {
            x: {
              0: { side: 'bottom', label: 'Forecast-' + for_year }
            }
          },
          bar: { groupWidth: "60%" }
        };

        var chart = new google.charts.Bar(document.getElementById('columnchart_values'));
        chart.draw(data, google.charts.Bar.convertOptions(options));
      }
    }
  });
};
