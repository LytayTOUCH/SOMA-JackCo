$(document).on('ready page:load', function() {
  $('.block_id').change(
    function() {
      $('.tree_amount').show();
      var block_id = $(".block_id").val();
      jQuery.ajax({
        url: "/get_tree_amounts",
        type: "GET",
        data: {"block_id" : block_id},
        dataType: "json",
        success: function(data) {
          $.each(data, function(i, value) {
            $(".tree_amount").val(value.tree_amount);
          });
        }
      });
    }
  );

  $('.block_id').change(
    function() {
      $('.planting_project').show();
      var block_id = $(".block_id").val();
      jQuery.ajax({
        url: "/get_block_planting_project_data",
        type: "GET",
        data: {"block_id" : block_id},
        dataType: "json",
        success: function(data){
          $('input.planting_project_id').val(data.uuid);
          $('input.planting_project_name').val(data.name);
        }
      });      
    }
  );

  $('.warehouse_id').change(
    function() {
      $('.warehouse').show();
      var warehouse_id = $(".warehouse_id").val();
      jQuery.ajax({
        url: "/get_warehouses_data",
        type: "GET",
        data: {"warehouse_id" : warehouse_id},
        dataType: "json",
        success: function(data){
          $.each(data, function(i, value) {
            console.log(i + ", " + value.uuid);
            console.log(i + ", " + value.name);
            // $('input.warehouse_id').val(data.uuid);
            // $('input.warehouse_name').val(data.name);
          });
        }
      });      
    }
  );

});