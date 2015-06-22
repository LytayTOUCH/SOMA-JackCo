$(document).ready(function() {
  $('.date_pick').datetimepicker({});

  var planting_project_id = $(".planting_project_id").val();
  if(planting_project_id!="") {
    // START -- EQUIPMENT SECTION
    $('#equipments').val("");
    $('select.item-select-equipments').html('');
    
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
  }
  
  // WHEN USER CHANGE THE FARM
  $("#output_task_farm_id").change(function(){
  	$('#distribution').hide();
  	$('#output_task_tree_amount').val("");
  	$('#output_task_planting_project_id').val("");
  	$('#output_task_name').val("");
  	$('.planting_project_name').val("");
  	
  	// START -- EQUIPMENT SECTION
    $('#equipments').val("");
    $('select.item-select-equipments').html('');
    
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
  	
  	if($("#output_task_farm_id").val() == "") {
      $("#output_task_zone_id").val("");
      $('#output_task_zone_id').prop('disabled', 'disabled');
  	} else {
      $('#output_task_zone_id').prop('disabled', false);
      
      var farm_id = $("#output_task_farm_id").val();
      jQuery.ajax({
        url: "/get_zones_by_farm",
        type: "GET",
        data: {"farm_id" : farm_id},
        dataType: "json",
        success: function(data){
          $('#output_task_zone_id').empty();
          $('#output_task_zone_id').append('<option value=""></option>');
          $.each(data, function(i, value) {
            $('#output_task_zone_id').append('<option value="' + value.uuid + '">' + value.name + '</option>');
          });
        }
      });
  	}
    
    $("#output_task_area_id").val("");
    $('#output_task_area_id').prop('disabled', 'disabled');
    
    $("#output_task_block_id").val("");
    $('#output_task_block_id').prop('disabled', 'disabled');
  });
  
  // WHEN USER CHANGE THE ZONE
  $("#output_task_zone_id").change(function(){
  	$('#distribution').hide();
  	$('#output_task_tree_amount').val("");
  	$('#output_task_planting_project_id').val("");
  	$('#output_task_name').val("");
  	$('.planting_project_name').val("");
  	
  	// START -- EQUIPMENT SECTION
    $('#equipments').val("");
    $('select.item-select-equipments').html('');
    
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
  	
  	if($("#output_task_zone_id").val() == "") {
      $("#output_task_area_id").val("");
      $('#output_task_area_id').prop('disabled', 'disabled');
  	} else {
      $('#output_task_area_id').prop('disabled', false);
      
      var zone_id = $("#output_task_zone_id").val();
      jQuery.ajax({
        url: "/get_areas_by_zone",
        type: "GET",
        data: {"zone_id" : zone_id},
        dataType: "json",
        success: function(data){
          $('#output_task_area_id').empty();
          $('#output_task_area_id').append('<option value=""></option>');
          $.each(data, function(i, value) {
            $('#output_task_area_id').append('<option value="' + value.uuid + '">' + value.name + '</option>');
          });
        }
      });
  	}
    
    $("#output_task_block_id").val("");
    $('#output_task_block_id').prop('disabled', 'disabled');
  });
  
  // WHEN USER CHANGE THE AREA
  $("#output_task_area_id").change(function(){
  	$('#distribution').hide();
  	$('#output_task_tree_amount').val("");
  	$('#output_task_planting_project_id').val("");
  	$('#output_task_name').val("");
  	$('.planting_project_name').val("");
  	
  	// START -- EQUIPMENT SECTION
    $('#equipments').val("");
    $('select.item-select-equipments').html('');
    
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
  	
  	if($("#output_task_area_id").val() == "") {
      $("#output_task_block_id").val("");
      $('#output_task_block_id').prop('disabled', 'disabled');
  	} else {
      $('#output_task_block_id').prop('disabled', false);
      
      var area_id = $("#output_task_area_id").val();
      jQuery.ajax({
        url: "/get_blocks_by_area",
        type: "GET",
        data: {"area_id" : area_id},
        dataType: "json",
        success: function(data){
          $('#output_task_block_id').empty();
          $('#output_task_block_id').append('<option value=""></option>');
          $.each(data, function(i, value) {
            $('#output_task_block_id').append('<option value="' + value.uuid + '">' + value.name + '</option>');
          });
        }
      });
  	}
  });

  // WHEN USER CHANGE THE BLOCK 
  $('#output_task_block_id').change(function() {
  	if($('#output_task_block_id').val() == "") {
  	  $('#distribution').hide();
  	  $('#output_task_tree_amount').val("");
  	  $('#output_task_planting_project_id').val("");
  	  $('#output_task_name').val("");
  	  $('.planting_project_name').val("");
  	  
  	  // START -- EQUIPMENT SECTION
      $('#equipments').val("");
      $('select.item-select-equipments').html('');
      
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
    var block_id = $('#output_task_block_id').val();
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
    //var block_id = $('#output_task_block_id').val();
    jQuery.ajax({
      url: "/get_block_planting_project_data",
      type: "GET",
      data: {"block_id" : block_id},
      dataType: "json",
      success: function(data){
        $('input.planting_project_id').val(data.uuid);
        $('input.planting_project_name').val(data.name);

		//START--APPLICATION SECTION
        $('#output_task_name').empty();
	    jQuery.ajax({
	      url: "/get_output_application_data",
	      type: "GET",
	      data: {"planting_project_id" : data.uuid},
	      dataType: "json",
	      success: function(data){
	      	$.each(data, function(i, value) {
	          $('#output_task_name').append('<option value="'+value.uuid+'">'+value.name+'</option>');
	        });
	      }
	    });
	    //END----APPLICATION SECTION
		
        renderEquipment();

        // DISTRIBUTION SECTION
        $('#distribution').empty();
        $('#distribution').append("<h3>Distribution - "+data.name+"</h3><hr/>");
  	    $('#distribution').show();
  	    jQuery.ajax({
	      url: "/get_distributions_by_planting_project",
	      type: "GET",
	      data: {"planting_project_id" : data.uuid},
	      dataType: "json",            
	      success: function(data) {
	        $.each(data, function(i, value) {
	          
	          var result = "<div class='form-group'><label class='col-xs-3 control-label text-left'>"+ value.label +"</label>";
	          
	          var uoms = value.uoms.split(",");
	          var length = uoms.length;
              for (var i = 0; i < length; i++) {
              	result += '<div class="col-xs-4">'
				             +'<div class="input-group">'
				               +'<div class="input float required">'
				                 +'<input class="numeric float required form-control" type="number" value="0.0" step="any" name="distribution_amounts[]">'
				                 +'<input type="hidden" value="'+ value.uuid +'" name="distribution_ids[]">'
				                 +'<input type="hidden" value="'+ uoms[i].split("|")[0] +'" name="uom_ids[]">'
				               +'</div>'
				               +'<span class="input-group-addon">' + uoms[i].split("|")[1] + '</span>'
				             +'</div>'
	                       +'</div>';
              }
              
              result += "</div>";
	          
	          $('#distribution').append(result);
	        });
	      }
	    });

        // Get data for Chosen when Planting project has data
        $('select.item-select-machinaries').html('');
        var planting_project_id = $(".planting_project_id").val();
        jQuery.ajax({
          url: "/get_machinery_data",
          type: "GET",
          data: {"planting_project_id" : planting_project_id},
          dataType: "json",
          success: function(data){
            if(data.length){
              $.each(data, function(i, value) {
                $('select.item-select-machinaries').append('<option value="' + value.uuid + '">' + value.name + '</option>');
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
            );
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
      if(!params.selected) {
        $('#machinery-' + params.deselected).remove();
        $('#machineries').val($(this).val());
      } else {
      	$('#machineries').val($(this).val());
        var machinery_id = params.selected;
        
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
	          str +=    '</label>';
	          str +=    '<div class="col-xs-4">';
	          str +=      '<label class="col-xs-4 control-label">Warehouse</label>';
	          str +=      '<div class="col-xs-8">';
	          str +=        '<select id="wh_'+ machinery_id +'" name="warehouses[]" class="warehouse-select form-control">';
	          str +=        '</select>';
	          str +=      '</div>';
	          str +=    '</div>';
	          str +=    '<div class="col-xs-3">';
	          str +=      '<label class="col-xs-4 control-label">Material</label>';
	          str +=      '<div class="col-xs-8">';
	          str +=        '<select id="material_'+ machinery_id +'" name="materials[]" class="material-select form-control">';
	          str +=        '</select>';
	          str +=      '</div>';
	          str +=    '</div>';
	          str +=    '<div class="col-xs-3">';
	          str +=      '<label class="col-xs-3 control-label">Qty</label>';
	          str +=      '<div class="col-xs-9">';
	          str +=        '<div class="input-group">'
					               +'<div class="input float required">'
					                 +'<input id="matqty_'+ machinery_id +'" name="material_qtys[]" class="form-control material-qty"></input>'
					               +'</div>'
					               +'<span id="span_'+ machinery_id +'" class="input-group-addon" />'
					       +'</div>';
	          str +=      '</div>';
	          str +=    '</div>';
	          str +=  '</div>';
	          str += '</div>';
	          
	          $('div.machinery-name').append(str);
			  
			  //SELECT WAREHOUSE SECTION
			  // $('select.warehouse-select').append('<option value=""></option>');
	          $.each(data.warehouse, function(i, value) {
	            $('select.warehouse-select').append('<option value=' + value.uuid + '>' + value.name + '</option>');
	          });
	          $('select.warehouse-select').change(function() {
			      var machinery_id = $(this).attr("id").split("_")[1];
			      
			      if ($(this).val()==""){
			      	$('#matqty_'+machinery_id).val("0");
			      }
			  });
	
			  //SELECT MATERIAL SECTION
			  // $('select.material-select').append('<option value=""></option>');
	          $.each(data.material, function(i, value) {
	            $('select.material-select').append('<option value='+ value.uuid +'>' + value.name + '</option>');
	          });

            //Start--Auto select UOM when select machinery
            var mat_id = $('select.material-select').val();
            jQuery.ajax({
              url: "/get_unit_of_measurement_data",
              type: "GET",
              data: {"material_uuid" : mat_id},
              dataType: "json",
              success: function(data){
                // $("span.uom-name-"+params.selected).html(data.name);
                $("#span_"+machinery_id).html(data.name);
              }
            }); 
            //End--Auto select UOM when select machinery

	          $('select.material-select').change(
			    function() {
			      var machinery_id = $(this).attr("id").split("_")[1];
			      
			      if ($(this).val()!=""){
			      	var material_id = $(this).val();
			      
	                jQuery.ajax({
	                  url: "/get_unit_of_measurement_data",
	                  type: "GET",
			          data: {"material_uuid" : material_id},
			          dataType: "json",
			          success: function(data){
			            $("#span_"+machinery_id).html(data.name);
			            $('#matqty_'+machinery_id).val("0");
			          }
			        });
			      } else {
			      	$("#span_"+machinery_id).html("");
			      }
			    }
			  );
			  
			  //INPUT MATERIAL QTY SECTION
			  $('.material-qty').blur(function() {
			  	var m_id = $(this).attr("id").split("_")[1];
			  	if($('#wh_'+m_id).val()!="" && $('#material_'+m_id).val()!="" && $('#matqty_'+m_id).val()!="") {
		  		  jQuery.ajax({
	                url: "/get_warehouse_material_amount_data",
	                type: "GET",
		            data: {
		            	"material_id" : $('#material_'+m_id).val(),
		            	"warehouse_id" : $('#wh_'+m_id).val(),
		            },
		            dataType: "json",
		            success: function(data){
		              input = parseFloat($('#matqty_'+m_id).val());
		              remain = parseFloat(data.amount);
		              if(input > remain) {
		              	alert('Input quantity exceeds the quantity in the stock.'+
		              	      '\nPlease adjust the stock or create a stock-in transaction.'+
		              	      '\nRemaining Balance: '+ remain);
		              	$('#matqty_'+m_id).focus();
		              	$('#matqty_'+m_id).val("0");
		              }
		            }
		          });
			  	}
			  });
	        }
	      });
      }
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
          str +=    '</label>';
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
          $('select.item-select-equipments').attr("data-placeholder", "Select some items");
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
        );
      }
    });
    //End-- Start Get Equipment and select Equipment
  }
  
  function renderMachinery() {
  	// Get data for Chosen when Planting project has data
    $('select.item-select-machinaries').html('');
    $('#machineries').val("");
    $('select.item-select-equipments').html('');
    $('#equipments').val("");
        
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
          $('select.item-select-machinaries').attr("data-placeholder", "Select some items");
        }
        else{
          $('select.item-select-machinaries').attr("data-placeholder", "No Items");
        }
        $('select.item-select-machinaries').trigger('chosen:updated');
      }
    });
  }
  
  //Equipment
  $('select.item-select-equipments').change(function(event, params){              

    // Creating a row of Equipment when data from chosen
    if(event.target == this){
      console.log($(this).val());
      $('#equipments').val($(this).val());
      var equipment_id = params.selected;
      console.log(equipment_id);
      
    }
  });
  // End Equipment
});