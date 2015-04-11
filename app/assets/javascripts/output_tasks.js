$(document).ready(function() {
  $('.machinery-name').hide();
  // block_id is id for Block. When we select block 
  $('.block_id').change(function() {
      // Get data for Tree amount when selecting block
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

      // Get data for Planting Project when selecting block
      $('.planting_project').show();
      //var block_id = $(".block_id").val();
      jQuery.ajax({
        url: "/get_block_planting_project_data",
        type: "GET",
        data: {"block_id" : block_id},
        dataType: "json",
        success: function(data){
          $('input.planting_project_id').val(data.uuid);
          $('input.planting_project_name').val(data.name);

          jQuery.ajax({
            url: "/get_production_by_planting_project",
            type: "GET",
            data: {"planting_project_id" : data.uuid},
            dataType: "json",
            success: function(data){
              $('select.production_ids').empty();
              $.each(data, function(i, value) {
                $('select.production_ids').append('<option value="'+value.uuid+'">'+value.status+'</option>');
              });
            }
          }); 

          // Get data for Chosen when Planting project has data
          $('select.item-select-machinaries').html('');
          $('.warehouse').show();
          var planting_project_id = $(".planting_project_id").val();
          jQuery.ajax({
            url: "/get_machinery_data",
            type: "GET",
            data: {"planting_project_id" : planting_project_id},
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
                $('.machinery-name').show();

                // Creating a row of Machinery when data from chosen

                if(event.target == this){
                  console.log($(this).val());
                  $('#machineries').val($(this).val());

                  // $('.machinery-name').empty();

                  var machinery_id = $(this).val();
                  console.log(machinery_id);
                  if(machinery_id == null) {
                    $(".machinery_name").empty();
                  }
                  
                  jQuery.ajax({
                  url: "/get_machinery_name",
                  type: "GET",
                  data: {"machinery_id" : machinery_id},
                  beforeSend: function(){
                    //​​​​ $(".machinery_name").empty();
                    
                  },
                  dataType: "json",
                    success: function(data){
                      console.log(data);
                      // $.each(data, function(i, value) {
                      //   console.log(value.name);
                      // });
                      $('div.machinery_name').append('<div class="form-group"><label class="col-xs-2 control-label">'+data.name+'</label><label class="col-xs-1 control-label">Warehouse</label><div class="col-xs-2"><select class="form-control"><option value="">Test</option><option value="">Test1</option><option value="">Test2</option></select></div>  <label class="col-xs-1 control-label">Material</label><div class="col-xs-2"><select class="form-control"><option value="">Test</option><option value="">Test1</option><option value="">Test2</option></select></div>  <label class="col-xs-1 control-label">Qty</label><div class="col-xs-1"><input class="form-control"></input></div></div><br/>');
                    }
                  });  



                }
              });  
            }
          });
        }
      });  
    }
  );

  $('.warehouse_id').change(
    function() {
      $('select.item-select-machinaries').html('');
      $('.warehouse').show();
      var planting_project_id = $(".planting_project_id").val();
      jQuery.ajax({
        url: "/get_machinery_data",
        type: "GET",
        data: {"planting_project_id" : planting_project_id},
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
            }
          });  
        }
      });   
    }
  );

});