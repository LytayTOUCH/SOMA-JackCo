// $(document).ready(function() {
//   $('.uom').hide();
//   $('.material_id').change(
//     function() {
//       $('.uom').show();     
//     }
//   );
// });

$(document).ready(function() {
  $('.unit-of-measurement-name').hide();
  $('.material_uuid').change(
    function() {
      $('.unit-of-measurement-name').show();
      var material_uuid = $(".material_uuid").val();
      jQuery.ajax({
        url: "/get_unit-of-measurement_data",
        type: "GET",
        data: {"material_uuid" : material_uuid},
        dataType: "json",
        success: function(data){
          $.each(data, function(i, value) {
            $(".material_uuid").val(value.uuid);
            $(".material_name").val(value.name);
          });
        }
      });
      
    }
  );
});