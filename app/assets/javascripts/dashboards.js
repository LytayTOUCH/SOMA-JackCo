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
