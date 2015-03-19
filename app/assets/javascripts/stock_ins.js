$(document).on('ready page:load', function() {
  $('.material_uuid').change(
    function() {
      $('.uom-name').show();
      var material_uuid = $(".material_uuid").val();
      jQuery.ajax({
        url: "/get_unit_of_measurement_data",
        type: "GET",
        data: {"material_uuid" : material_uuid},
        dataType: "json",
        success: function(data){
          $("span.uom-name").html(data.name);
        }
      });      
    }
  );
});