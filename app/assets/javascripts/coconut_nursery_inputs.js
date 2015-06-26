$(document).ready(function() {
  $('#coconut_nursery_input_nursery_date').datetimepicker();
  
  Date.prototype.yyyymmdd = function() {
   var yyyy = this.getFullYear().toString();
   var mm = (this.getMonth()+1).toString(); // getMonth() is zero-based
   var dd  = this.getDate().toString();
   return yyyy + '-' + (mm[1]?mm:"0"+mm[0]) + '-' + (dd[1]?dd:"0"+dd[0]); // padding
  };
  
  $("#coconut_nursery_input_nursery_date").on("dp.change", function (e) {
    var d = new Date(e.date);
    d.setMonth(d.getMonth() + 3);
    $('#coconut_nursery_input_receive_date').val(d.yyyymmdd());
  });
  
  $("#coconut_nursery_input_input_processing_qty").change(function(){
    sumTotalQty();
  });
  
  $("#coconut_nursery_input_input_spoil_qty").change(function(){
    sumTotalQty();
  });
  
  function sumTotalQty() {
    var process = $("#coconut_nursery_input_input_processing_qty").val() == "" ? 0 : $("#coconut_nursery_input_input_processing_qty").val();
    var spoil = $("#coconut_nursery_input_input_spoil_qty").val() == "" ? 0 : $("#coconut_nursery_input_input_spoil_qty").val();
    $("#coconut_nursery_input_input_total_qty").val(parseInt(process) + parseInt(spoil));
  }
  
  $('#coconut_nursery_input_warehouse_id').change(function(){
    $("#qty_in_stock").val("");
    
    if ($('#coconut_nursery_input_warehouse_id').val() != "") {
      var warehouse_id = $('#coconut_nursery_input_warehouse_id').val();
      
      //00000000-0000-0000-0000-000000000011 - is Coconut To Nursery Warehouse
      
      jQuery.ajax({
        url: "/get_qty_production_in_stock",
        type: "GET",
        data: {
          "warehouse_id" : warehouse_id,
          "distribution_id" : "00000000-0000-0000-0000-000000000011"
        },
        dataType: "json",
        success: function(data){
          $("#qty_in_stock").val(data.amount);
        }
      });
    }
  });
});