$(document).on('ready page:load', function() {
  $('.labor_uuid').change(
    function() {
      $('.labor-email').show();
      var labor_uuid = $(".labor_uuid").val();
      jQuery.ajax({
        url: "/get_labor_email_data",
        type: "GET",
        data: {"labor_uuid" : labor_uuid},
        dataType: "json",
        success: function(data){
          // $("span.labor-email").html(data.email);
          $(".labor-email").val(data.email);
        }
      });      
    }
  );
}); 
// http://localhost:3000/get_labor_email_data?labor_uuid=A616431E-BE2E-11E4-954C-E0DB55A6E603