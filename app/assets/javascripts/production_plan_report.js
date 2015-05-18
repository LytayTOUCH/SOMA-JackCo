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
          ["Jan-" + for_year.substring(2, 4), data.jan],
          ["Feb-" + for_year.substring(2, 4), data.feb],
          ["Mar-" + for_year.substring(2, 4), data.mar],
          ["Apr-" + for_year.substring(2, 4), data.apr],
          ["May-" + for_year.substring(2, 4), data.may],
          ["Jun-" + for_year.substring(2, 4), data.jun],
          ["Jul-" + for_year.substring(2, 4), data.jul],
          ["Aug-" + for_year.substring(2, 4), data.aug],
          ["Sep-" + for_year.substring(2, 4), data.sep],
          ["Oct-" + for_year.substring(2, 4), data.oct],
          ["Nov-" + for_year.substring(2, 4), data.nov],
          ["Dec-" + for_year.substring(2, 4), data.dec]
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
