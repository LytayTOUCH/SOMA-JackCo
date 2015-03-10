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
                $("#"+value.uuid).append("<td><input material_uuid='"+value.uuid+"' type='number' class='' size='15' style='width: 90px; border-radius: 4px; border: 1px solid #cccccc; padding: 6px 12px;' placeholder='Amount'><i class='fa fa-check-square-o fa-lg' title='Save', style='padding: 4px;'></i></td>");
              }

            });
          }
        });
        
      }
    );
});