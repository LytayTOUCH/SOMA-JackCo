$(document).ready(function() {
    $('.warehouse-name').hide();
    $('.material_id').change(
      function() {
        $('.warehouse-name').show();
        // $(".warehouse_name").css("visibility","visible");

        // var material_id = $(".material_id").val();
        // jQuery.ajax({
        //   url: "/get_warehouse_data",
        //   type: "GET",
        //   data: {"material_id" : material_id},
        //   dataType: "json",
        //   success: function(data){
        //     $.each(data, function(i, value) {
        //       $(".warehouse_uuid").val(value.uuid);
        //       $(".warehouse_name").val(value.name);
        //     });
        //   }
        // });
        
      }
    );
});