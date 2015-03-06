$(document).ready(function() {
    $('.material-name').hide();
    $('.material_category_uuid').change(
      function() {
        $('.material-name').show();

        var material_category_uuid = $(".material_category_uuid").val();
        jQuery.ajax({
          url: "/get_material_data",
          type: "GET",
          data: {"material_cate_uuid" : material_category_uuid},
          dataType: "json",
          success: function(data){
            // $(".material_id").empty();
            $(".material_name").empty();
            $.each(data, function(i, value) {
              // $(".material_id").append('<input type="hidden" name="material_uuid" value="'+value.uuid+'">');

              $(".material_name").append("<tr id='"+value.uuid+"'><td>"+value.name+"</td></tr>");

              var warehouse_amount = $("#warehouse_amount").val();
              for(var i = 0 ; i<warehouse_amount ; i++) {
                $("#"+value.uuid).append("<td><input type='number' size='15' value='0' style='width: 80px;'></td>");
              }
              // console.log(i+"," +value);
              // $('span.test').html(i+", "+value);

            });
          }
        });
        
      }
    );
});