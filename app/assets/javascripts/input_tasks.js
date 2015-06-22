$(document).ready(function(){
	$('.machinery-name').hide();
	$('.material-name').hide();

  var planting_project_id = $(".planting_project_id").val();
  if(planting_project_id!="") {
    // START -- EQUIPMENT SECTION
    $('#equipments').val("");
    $('select.item-select-equipments').html('');
    $('select.item-select-equipments').attr("multiple", "multiple");
    $("select.chosen-select-equipment").chosen(
      {width: "100%"},
      {no_results_text: 'No results matched'}
    );
    
    $('select.item-select-equipments').attr("data-placeholder", "No Items");
    $('select.item-select-equipments').trigger('chosen:updated');
    // END -- EQUIPMENT SECTION
    
    renderEquipment();
    renderMachinery();
  }
  
  // WHEN USER CHANGE THE FARM
  $("#input_task_farm_id").change(function(){
    $('#input_task_tree_amount').val("");
    $('#input_task_planting_project_id').val("");
    $('#input_task_name').val("");
    $('.planting_project_name').val("");

    // START -- EQUIPMENT SECTION
    $('#equipments').val("");
    $('select.item-select-equipments').html('');
    $('select.item-select-equipments').attr("multiple", "multiple");
    $("select.chosen-select-equipment").chosen(
      {width: "100%"},
      {no_results_text: 'No results matched'}
    );
    
    $('select.item-select-equipments').attr("data-placeholder", "No Items");
    $('select.item-select-equipments').trigger('chosen:updated');
    // END -- EQUIPMENT SECTION
    
    // START -- MACHINERY SECTION
    $('#machineries').val("");
    $('.machinery-name').empty();
    
    $('select.item-select-machinaries').html('');
    $('select.item-select-machinaries').attr("multiple", "multiple");
    $("select.chosen-select").chosen(
      {width: "100%"},
      {no_results_text: 'No results matched'}
    );
    
    $('select.item-select-machinaries').attr("data-placeholder", "No Items");
    $('select.item-select-machinaries').trigger('chosen:updated');
    // END -- MACHINERY SECTION
    
    if($("#input_task_farm_id").val() == "") {
      $("#input_task_zone_id").val("");
      $('#input_task_zone_id').prop('disabled', 'disabled');
    } else {
      $('#input_task_zone_id').prop('disabled', false);
      
      var farm_id = $("#input_task_farm_id").val();
      jQuery.ajax({
        url: "/get_zones_by_farm",
        type: "GET",
        data: {"farm_id" : farm_id},
        dataType: "json",
        success: function(data){
          $('#input_task_zone_id').empty();
          $('#input_task_zone_id').append('<option value=""></option>');
          $.each(data, function(i, value) {
            $('#input_task_zone_id').append('<option value="' + value.uuid + '">' + value.name + '</option>');
          });
        }
      });
    }
    
    $("#input_task_area_id").val("");
    $('#input_task_area_id').prop('disabled', 'disabled');
    
    $("#input_task_block_id").val("");
    $('#input_task_block_id').prop('disabled', 'disabled');
  });
  
  // WHEN USER CHANGE THE ZONE
  $("#input_task_zone_id").change(function(){
    $('#input_task_tree_amount').val("");
    $('#input_task_planting_project_id').val("");
    $('#input_task_name').val("");
    $('.planting_project_name').val("");
    
    // START -- EQUIPMENT SECTION
    $('#equipments').val("");
    $('select.item-select-equipments').html('');
    $('select.item-select-equipments').attr("multiple", "multiple");
    $("select.chosen-select-equipment").chosen(
      {width: "100%"},
      {no_results_text: 'No results matched'}
    );
    
    $('select.item-select-equipments').attr("data-placeholder", "No Items");
    $('select.item-select-equipments').trigger('chosen:updated');
    // END -- EQUIPMENT SECTION

    // START -- MACHINERY SECTION
    $('#machineries').val("");
    $('.machinery-name').empty();
    
    $('select.item-select-machinaries').html('');
    $('select.item-select-machinaries').attr("multiple", "multiple");
    $("select.chosen-select").chosen(
      {width: "100%"},
      {no_results_text: 'No results matched'}
    );
    
    $('select.item-select-machinaries').attr("data-placeholder", "No Items");
    $('select.item-select-machinaries').trigger('chosen:updated');
    // END -- MACHINERY SECTION
    
    if($("#input_task_zone_id").val() == "") {
      $("#input_task_area_id").val("");
      $('#input_task_area_id').prop('disabled', 'disabled');
    } else {
      $('#input_task_area_id').prop('disabled', false);
      
      var zone_id = $("#input_task_zone_id").val();
      jQuery.ajax({
        url: "/get_areas_by_zone",
        type: "GET",
        data: {"zone_id" : zone_id},
        dataType: "json",
        success: function(data){
          $('#input_task_area_id').empty();
          $('#input_task_area_id').append('<option value=""></option>');
          $.each(data, function(i, value) {
            $('#input_task_area_id').append('<option value="' + value.uuid + '">' + value.name + '</option>');
          });
        }
      });
    }
    
    $("#input_task_block_id").val("");
    $('#input_task_block_id').prop('disabled', 'disabled');
  });
  
  // WHEN USER CHANGE THE AREA
  $("#input_task_area_id").change(function(){
    $('#input_task_tree_amount').val("");
    $('#input_task_planting_project_id').val("");
    $('#input_task_name').val("");
    $('.planting_project_name').val("");
 
    // START -- EQUIPMENT SECTION
    $('#equipments').val("");
    $('select.item-select-equipments').html('');
    $('select.item-select-equipments').attr("multiple", "multiple");
    $("select.chosen-select-equipment").chosen(
      {width: "100%"},
      {no_results_text: 'No results matched'}
    );
    
    $('select.item-select-equipments').attr("data-placeholder", "No Items");
    $('select.item-select-equipments').trigger('chosen:updated');
    // END -- EQUIPMENT SECTION

    // START -- MACHINERY SECTION
    $('#machineries').val("");
    $('.machinery-name').empty();
    
    $('select.item-select-machinaries').html('');
    $('select.item-select-machinaries').attr("multiple", "multiple");
    $("select.chosen-select").chosen(
      {width: "100%"},
      {no_results_text: 'No results matched'}
    );
    
    $('select.item-select-machinaries').attr("data-placeholder", "No Items");
    $('select.item-select-machinaries').trigger('chosen:updated');
    // END -- MACHINERY SECTION
    
    if($("#input_task_area_id").val() == "") {
      $("#input_task_block_id").val("");
      $('#input_task_block_id').prop('disabled', 'disabled');
    } else {
      $('#input_task_block_id').prop('disabled', false);
      
      var area_id = $("#input_task_area_id").val();
      jQuery.ajax({
        url: "/get_blocks_by_area",
        type: "GET",
        data: {"area_id" : area_id},
        dataType: "json",
        success: function(data){
          $('#input_task_block_id').empty();
          $('#input_task_block_id').append('<option value=""></option>');
          $.each(data, function(i, value) {
            $('#input_task_block_id').append('<option value="' + value.uuid + '">' + value.name + '</option>');
          });
        }
      });
    }
  });

  // WHEN USER CHANGE THE BLOCK 
  $('#input_task_block_id').change(function() {
    if($('#input_task_block_id').val() == "") {
      $('#input_task_tree_amount').val("");
      $('#input_task_planting_project_id').val("");
      $('#input_task_name').val("");
      $('.planting_project_name').val("");
   
      // START -- EQUIPMENT SECTION
      $('#equipments').val("");
      $('select.item-select-equipments').html('');
      $('select.item-select-equipments').attr("multiple", "multiple");
      $("select.chosen-select-equipment").chosen(
        {width: "100%"},
        {no_results_text: 'No results matched'}
      );
      
      $('select.item-select-equipments').attr("data-placeholder", "No Items");
      $('select.item-select-equipments').trigger('chosen:updated');
      // END -- EQUIPMENT SECTION

      // START -- MACHINERY SECTION
      $('#machineries').val("");
      $('.machinery-name').empty();
      
      $('select.item-select-machinaries').html('');
      $('select.item-select-machinaries').attr("multiple", "multiple");
      $("select.chosen-select").chosen(
        {width: "100%"},
        {no_results_text: 'No results matched'}
      );
      
      $('select.item-select-machinaries').attr("data-placeholder", "No Items");
      $('select.item-select-machinaries').trigger('chosen:updated');
      // END -- MACHINERY SECTION
      
      return;
    }
    
    // Get data for Tree amount when selecting block
    $('.machinery-name').empty();
    
    $('.tree_amount').show();
    var block_id = $('#input_task_block_id').val();
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
    jQuery.ajax({
      url: "/get_block_planting_project_data",
      type: "GET",
      data: {"block_id" : block_id},
      dataType: "json",
      success: function(data){
        $('input.planting_project_id').val(data.uuid);
        $('input.planting_project_name').val(data.name);
        
        //START--APPLICATION SECTION
        $('#input_task_name').empty();
	    jQuery.ajax({
	      url: "/get_input_application_data",
	      type: "GET",
	      data: {"planting_project_id" : data.uuid},
	      dataType: "json",
	      success: function(data){
	      	$.each(data, function(i, value) {
	          $('#input_task_name').append('<option value="'+value.uuid+'">'+value.name+'</option>');
	        });
	      }
	    });
	    //END----APPLICATION SECTION

        renderEquipment();
        renderMachinery();
      }
    });  
  });

    //INPUT TREE AMOUNT SECTION
    $(".tree_amount").blur(function() {
      var tree_amount_input = $(".tree_amount").val();
      var block_ids = $('#input_task_block_id').val();
      if(tree_amount_input != "") {
        jQuery.ajax({
          url: "/get_tree_amounts",
          type: "GET",
          data: {"block_id" : block_ids},
          dataType: "json",
          success: function(data){
            $.each(data, function(i, value) {
              input = parseFloat(tree_amount_input);
              remain = parseFloat(value.tree_amount);
              if(input > remain) {
                alert("Input tree amount cannot over than block's tree amount."+
                      "\nBlock's tree amount: "+ remain);
                $('.tree_amount').focus();
                $('.tree_amount').val(value.tree_amount);
              }
            });
          }
        });
      }
    });
    //END--INPUT TREE AMOUNT SECTION

  function renderEquipment() {
    //Start Get Equipment and select Equipment
    // Get data for Chosen Equipment when Planting project has data
    $('select.item-select-equipments').html('');
    $('#equipments').val("");

    var planting_project_id = $(".planting_project_id").val();
    jQuery.ajax({
      url: "/get_equipment_data",
      type: "GET",
      data: {"planting_project_id" : planting_project_id},
      dataType: "json",
      success: function(data){
        if(data.length){
          $.each(data, function(i, value) {
            $('select.item-select-equipments').append('<option value="'+value.uuid+'">'+value.name+'</option>');
          });
          $('select.item-select-equipments').attr("multiple", "multiple");
          $('select.item-select-equipments').attr("data-placeholder", "Select Some Options");
        }
        else{
          $('select.item-select-equipments').attr("data-placeholder", "No Items");
          $('select.item-select-equipments').attr("multiple", "multiple");
        }
        $('select.item-select-equipments').trigger('chosen:updated');
      },
      complete: function(data){
        $("select.chosen-select-equipment").chosen(
          {width: "100%"},
          {allow_single_deselect: true},
          {no_results_text: 'No results matched'}
        )  
      }
    });
    //End-- Start Get Equipment and select Equipment
  }

  function renderMachinery() {
    // Get data for Chosen when Planting project has data
    $('select.item-select-machinaries').html('');
    $('#machineries').val("");
        
    var planting_project_id = $(".planting_project_id").val();
    jQuery.ajax({
      url: "/get_machinery_data",
      type: "GET",
      data: {"planting_project_id" : planting_project_id},
      dataType: "json",
      success: function(data){       
        $('select.item-select-machinaries').attr("multiple", "multiple");
        $("select.chosen-select").chosen(
          {width: "100%"},
          {no_results_text: 'No results matched'}
        );
        
        if(data.length){
          $('select.item-select-machinaries').append('<option value=""></option>');
          $.each(data, function(i, value) {
            $('select.item-select-machinaries').append('<option value="' + value.uuid + '">' + value.name + '</option>');
          });
          $('select.item-select-machinaries').attr("data-placeholder", "Select Some Options");
        }
        else{
          $('select.item-select-machinaries').attr("data-placeholder", "No Items");
        }
        $('select.item-select-machinaries').trigger('chosen:updated');
      }
    });
  }

  //Get equipment_id when select equipment
  $('select.item-select-equipments').change(function(event, params){              

    // Creating a row of Equipment when data from chosen
    if(event.target == this){
      console.log($(this).val());
      $('#equipments').val($(this).val());
      var equipment_id = params.selected;
      console.log(equipment_id);      
    }
  });
  // End-- Get equipment_id when select equipment

  $('select.item-select-machinaries').change(function(event, params){
    $('.machinery-name').show();

    if(!params.selected) {    
        console.log("machinery-" + params.deselected);               
        $('#machinery-'+params.deselected).remove();
    }                

    // Creating a row of Machinery when data from chosen
    if(event.target == this){
      console.log($(this).val());
      $('#machineries').val($(this).val());
      var machinery_id = params.selected;
      var sub_machinery_id = params.selected;
      console.log(machinery_id);

      jQuery.ajax({
      url: "/get_machinery_name",
      type: "GET",
      data: {"machinery_id" : machinery_id},
      beforeSend: function(){},
      dataType: "json",
        success: function(data){
          var str = "";
          str += '<div id="machinery-' + machinery_id + '">';
          str +=  '<div class="form-group">';                      
          str +=    '<label class="col-xs-2 control-label">';
          str +=      data.machinery_name.name;
          str +=    '</label>'
          str +=    '<label class="col-xs-1 control-label" style="width: 10%;">Warehouse*</label>';
          str +=    '<div class="col-xs-2">';
          str +=      '<select name="warehouses_of_machinery[]" class="warehouse-select-'+params.selected+' form-control" id="warehouse_select-'+params.selected+'">';
          str +=      '</select>';
          str +=      '<span id="warehouse_select_msg-'+params.selected+'" style="color: red;"></span>';
          str +=    '</div>';
          str +=    '<label class="col-xs-1 control-label">Material*</label>';
          str +=    '<div class="col-xs-2">';
          str +=      '<select name="materials_of_machinery[]" class="material-select-'+params.selected+' form-control" id="material_select-'+params.selected+'">';
          str +=      '</select>';
          // str +=      '<span id="material_select_msg-'+params.selected+'" style="color: red;"></span>';
          str +=    '</div>';
          str +=    '<label class="col-xs-1 control-label">Qty*</label>';
          str +=    '<div class="col-xs-2 material-qtys">';
          str +=      '<div class="input-group">';
          str +=        '<input type="number" name="material_qtys_of_machinery[]" class="form-control material-qty" id="material_qty_request-'+params.selected+'" value="0"></input>';
          str +=        '<span class="input-group-addon uom-name-' + params.selected + '">';
          str +=        '</span>';
          str +=      '</div>';
          str +=    '</div>';
          str +=  '</div>';
          str += '</div>';
          
          $('div.machinery-name').append(str);

          $.each(data.warehouse, function(i, value) {
            $('select.warehouse-select-'+params.selected).append('<option value=' + value.uuid + '>' + value.name + '</option></select>');
          });

          $.each(data.material, function(i, value) {
            $('select.material-select-'+params.selected).append('<option value='+ value.uuid +'>' + value.name + '</option>');
          });

          if(data.material == ""){
            $('select.material-select-'+params.selected).append('<option value=""></option>');
          }

          //Start--Auto select UOM when select machinery
          var mat_id = $('select.material-select-'+params.selected).val();
          jQuery.ajax({
            url: "/get_unit_of_measurement_data",
            type: "GET",
            data: {"material_uuid" : mat_id},
            dataType: "json",
            success: function(data){
              $("span.uom-name-"+params.selected).html(data.name);
            }
          }); 
          //End--Auto select UOM when select machinery

          //INPUT MATERIAL QTY SECTION (Machinery choosen)
          $("#material_qty_request-"+params.selected).blur(function() {
            var warehouse_id = $(".warehouse-select-"+params.selected).val();
            var material_id = $(".material-select-"+params.selected).val();
            var material_quantity_val = $("#material_qty_request-"+params.selected).val();
            if(warehouse_id != "" && material_id != "" && material_quantity_val != "") {
              jQuery.ajax({
                url: "/get_warehouse_material_amount_data",
                type: "GET",
                data: {
                  "material_id" : material_id,
                  "warehouse_id" : warehouse_id,
                },
                dataType: "json",
                success: function(data){
                  input = parseFloat(material_quantity_val);
                  remain = parseFloat(data.amount);
                  if(input > remain) {
                    alert('Input quantity exceeds the quantity in the stock.'+
                          '\nPlease adjust the stock or create a stock-in transaction.'+
                          '\nRemaining Balance: '+ remain);
                    $('#material_qty_request-'+params.selected).focus();
                    $('#material_qty_request-'+params.selected).val("0");
                  }
                }
              });
            }
          });
          //END--INPUT MATERIAL QTY SECTION

          // Select Material with Show UOM
          $('.material-select-'+params.selected).change(
            function() {
              var material_id = $(".material-select-"+params.selected).val();
              jQuery.ajax({
                url: "/get_unit_of_measurement_data",
                type: "GET",
                data: {"material_uuid" : material_id},
                dataType: "json",
                success: function(data){
                  $("span.uom-name-"+params.selected).html(data.name);
                }
              });      
            }
          );
          // End Select Material with Show UOM
        }     
      }); 
    }
  });

	$('.material_uuid').change(
		function(event, params) {
			$('.material-name').show();

      // Creating a row of Material when data from chosen
      if(event.target == this){
        console.log($(this).val());
        $('#materials').val($(this).val());
        var material_uuid = params.selected;
        console.log(material_uuid);

        if(!params.selected) {    
          console.log("material-" + params.deselected);               
          $('#material-'+params.deselected).remove();
        }
        
        jQuery.ajax({
          url: "/get_material_name",
          type: "GET",
          data: {"material_uuid" : material_uuid},
          beforeSend: function(){},
          dataType: "json",
          success: function(data){
            var str = "";
            str += '<div id="material-' + material_uuid + '">';
            str +=  '<div class="form-group">';                      
            str +=    '<label class="col-xs-2 control-label">';
            str +=      data.material_name.name;
            str +=    '</label>'
            str +=    '<label class="col-xs-1 control-label" style="width: 10%;">Warehouse*</label>';
            str +=    '<div class="col-xs-2">';
            str +=      '<select name="warehouses_of_material[]" class="warehouse-select-material-'+params.selected+' form-control" id="warehouse_select_material-'+params.selected+'">';
            str +=      '</select>';
            // str +=      '<span id="warehouse_select_material_msg-'+params.selected+'" style="color: red;"></span>';
            str +=    '</div>';            
            str +=    '<label class="col-xs-1 control-label">Qty*</label>';
            str +=    '<div class="col-xs-2 material-qtys">';
            str +=      '<div class="input-group">';
            str +=        '<input type="number" name="material_qtys_of_material[]" class="form-control material-qty" id="materials_qty_request-'+params.selected+'" value="0"></input>';
            str +=        '<span class="input-group-addon uom-name">';
            str +=          data.material_uom.name;
            str +=        '</span>';
            str +=      '</div>';
            str +=    '</div>';            
            str +=  '</div>';
            str += '</div>';
            
            $('div.material-name').append(str);

            $.each(data.warehouse, function(i, value) {
              $('select.warehouse-select-material-'+params.selected).append('<option value=' + value.uuid + '>' + value.name + '</option></select>');
            });

            if (data.warehouse == ""){
              $('select.warehouse-select-material-'+params.selected).append('<option value=""></option></select>');
            }

            //INPUT MATERIAL QTY SECTION (Material choosen)
            $("#materials_qty_request-"+params.selected).blur(function() {
              var warehouse_id = $(".warehouse-select-material-"+params.selected).val();
              var material_id = material_uuid;
              var material_quantity_val = $("#materials_qty_request-"+params.selected).val();
              if(warehouse_id != "" && material_id != "" && material_quantity_val != "") {
                jQuery.ajax({
                  url: "/get_warehouse_material_amount_data",
                  type: "GET",
                  data: {
                    "material_id" : material_id,
                    "warehouse_id" : warehouse_id,
                  },
                  dataType: "json",
                  success: function(data){
                    input = parseFloat(material_quantity_val);
                    remain = parseFloat(data.amount);
                    if(input > remain) {
                      alert('Input quantity exceeds the quantity in the stock.'+
                            '\nPlease adjust the stock or create a stock-in transaction.'+
                            '\nRemaining Balance: '+ remain);
                      $('#materials_qty_request-'+params.selected).focus();
                      $('#materials_qty_request-'+params.selected).val("0");
                    }
                  }
                });
              }
            });
            //END--INPUT MATERIAL QTY SECTION
          }
        }); 
      }
		}
	);	
});