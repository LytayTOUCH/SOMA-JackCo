$(document).ready(function() {
  $('.machinery-name').hide();
  $('.machinery-from-map').hide();
  // block_id is id for Block. When we select block 
  $('.block_id').change(function() {
    // Get data for Tree amount when selecting block
    $('.machinery-name').empty();
    
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
              $('select.production_ids').append('<option value="' + value.uuid + '">' + value.status + '</option>');
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
            )  
          }
        });
      }
    });  
  });

  // Chosen in Output Task
  $('select.item-select-machinaries').change(function(event, params){
    $('.machinery-name').show();
      // Creating a row of Machinery when data from chosen
    
    if(event.target == this){
      $('#machineries').val($(this).val());
      var machinery_id = params.selected;
      
      if(!params.selected) {
        $('#machinery-' + params.deselected).remove();
      }
      
      jQuery.ajax({
      url: "/get_machinery_name",
      type: "GET",
      data: {"machinery_id" : machinery_id},
      beforeSend: function(){
        if (params.selected) {
          $('.warehouse-select').empty();
          $('.material-select').empty();
        }
      },
      dataType: "json",
        success: function(data){
          var str = "";
          str += '<div id="machinery-' + machinery_id + '">';
          str +=  '<div class="form-group">';                      
          str +=    '<label class="col-xs-2 control-label">';
          str +=      data.machinery_name.name;
          str +=    '</label>'
          str +=    '<label class="col-xs-1 control-label">Warehouse</label>';
          str +=    '<div class="col-xs-2">';
          str +=      '<select name="warehouses[]" class="warehouse-select form-control">';
          str +=      '</select>';
          str +=    '</div>';
          str +=    '<label class="col-xs-1 control-label">Material</label>';
          str +=    '<div class="col-xs-2">';
          str +=      '<select name="materials[]" class="material-select form-control">';
          str +=      '</select>';
          str +=    '</div>';
          str +=    '<label class="col-xs-1 control-label">Qty</label>';
          str +=    '<div class="col-xs-1">';
          str +=      '<input name="material_qtys[]" class="form-control material-qty"></input>';
          str +=    '</div>';
          str +=  '</div>';
          str += '</div>';
          
          $('div.machinery-from-map').append(str);

          $.each(data.warehouse, function(i, value) {
            $('select.warehouse-select').append('<option value=' + value.uuid + '>' + value.name + '</option></select>');
          });

          $.each(data.material, function(i, value) {
            $('select.material-select').append('<option value='+ value.uuid +'>' + value.name + '</option>');
          });
        }
      });       
    }
  }); 

  // Chosen in Output Task from Google Map
  $('select.machinery-chosen').change(function(event, params){
    $('.machinery-from-map').show();

    // Creating a row of Machinery when data from chosen
    if(event.target == this){
      $('#machineries').val($(this).val());
      var machinery_id = params.selected;
      
      if(!params.selected) {
        $('#machinery-' + params.deselected).remove();
      }
      
      jQuery.ajax({
      url: "/get_machinery_name",
      type: "GET",
      data: {"machinery_id" : machinery_id},
      beforeSend: function(){
        if (params.selected) {
          $('.warehouse-select').empty();
          $('.material-select').empty();
        }
      },
      dataType: "json",
        success: function(data){
          var str = "";
          str += '<div id="machinery-' + machinery_id + '">';
          str +=  '<div class="form-group">';                      
          str +=    '<label class="col-xs-2 control-label">';
          str +=      data.machinery_name.name;
          str +=    '</label>'
          str +=    '<label class="col-xs-1 control-label">Warehouse</label>';
          str +=    '<div class="col-xs-2">';
          str +=      '<select name="warehouses[]" class="warehouse-select form-control">';
          str +=      '</select>';
          str +=    '</div>';
          str +=    '<label class="col-xs-1 control-label">Material</label>';
          str +=    '<div class="col-xs-2">';
          str +=      '<select name="materials[]" class="material-select form-control">';
          str +=      '</select>';
          str +=    '</div>';
          str +=    '<label class="col-xs-1 control-label">Qty</label>';
          str +=    '<div class="col-xs-1">';
          str +=      '<input name="material_qtys[]" class="form-control material-qty"></input>';
          str +=    '</div>';
          str +=  '</div>';
          str += '</div>';
          
          $('div.machinery-from-map').append(str);

          $.each(data.warehouse, function(i, value) {
            $('select.warehouse-select').append('<option value=' + value.uuid + '>' + value.name + '</option></select>');
          });

          $.each(data.material, function(i, value) {
            $('select.material-select').append('<option value='+ value.uuid +'>' + value.name + '</option>');
          });
        }
      }); 
    }
  });  


  $('.warehouse_id').change(function() {
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
  });
  
});