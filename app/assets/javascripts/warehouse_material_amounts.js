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
            $(".material_name").empty();
            $.each(data, function(i, value) {
              // $(".material_uuid").val(value.uuid);
              $(".material_name").append("<tr><td>"+value.name+"</td></tr>");
              // console.log(i+"," +value);
              // $('span.test').html(i+", "+value);

            });
          }
        });
        
      }
    );
});