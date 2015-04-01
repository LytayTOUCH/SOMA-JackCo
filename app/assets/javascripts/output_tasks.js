$(document).ready(function(){
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
      $('select.item-select-machinaries').html('');
      $('.warehouse').show();
      var warehouse_id = $(".warehouse_id").val();
      jQuery.ajax({
        url: "/get_warehouses_data",
        type: "GET",
        data: {"warehouse_id" : warehouse_id},
        dataType: "json",
        beforeSend: function(){
          // $('select.item-select-machinaries').removeAttr("multiple");
          // $('select.item-select-machinaries').show();
          // $('select.item-select-machinaries').trigger('chosen:updated');
          // $('.chosen-container').remove();
          // $('select.output_task_block_id').show();
        }, 
        success: function(data){
          console.log(data);
          if(data.length){
            $.each(data, function(i, value) {
              console.log(i + ", " + value.uuid);
              console.log(i + ", " + value.name);
              //$('ul.chosen-results').append('<li class="active-result" data-option-array-index="1" id="'+value.uuid+'">'+value.name+'</li>');
              $('select.item-select-machinaries').append('<option value="'+value.uuid+'">'+value.name+'</option>');
            });
            $('select.item-select-machinaries').attr("multiple", "multiple");
          }
          else{

          }
          $('select.item-select-machinaries').trigger('chosen:updated');
        },
        complete: function(data){
          console.log(data.responseJSON);
          if(data.responseJSON.length){
            $("select.chosen-select").chosen(
              {width: "460px"},
              {allow_single_deselect: true},
              {no_results_text: 'No results matched'}
            );  
          }
          // else{

          // }
          
        }
      });      
    }
  );

});