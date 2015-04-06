$(document).on('ready page:load',function() {
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
      $('select.item-select-machinaries').html('');
      $('.warehouse').show();
      var warehouse_id = $(".warehouse_id").val();
      jQuery.ajax({
        url: "/get_warehouses_data",
        type: "GET",
        data: {"warehouse_id" : warehouse_id},
        dataType: "json",
        success: function(data){
          if(data.length){
            $.each(data, function(i, value) {
              $('select.item-select-machinaries').append('<option value="'+value.uuid+'">'+value.name+'</option>');
            });
            $('select.item-select-machinaries').attr("multiple", "multiple");
            $('select.item-select-machinaries').attr("data-placeholder", "Select some items");
          }
          else{
            $('select.item-select-machinaries').attr("data-placeholder", "No Items");
            $('select.item-select-machinaries').attr("multiple", "multiple");
          }
          $('select.item-select-machinaries').trigger('chosen:updated');
        },
        complete: function(data){
          $("select.chosen-select").chosen(
            {width: "100%"},
            {allow_single_deselect: true},
            {no_results_text: 'No results matched'}
          ).change(function(event){
            if(event.target == this){
              console.log($(this).val());
              $('#machineries').val($(this).val());
              // var value = $(this).val();
              // $("#result").text(value);
            }
          });  
        }
      });     
    }
  );

});