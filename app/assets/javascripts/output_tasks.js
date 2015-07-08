$(document).ready(function() {
  $("#new_output_task").keydown(function(event){
    if(event.keyCode == 13) {
      event.preventDefault();
      return false;
    }
  });
  
  $('.date_pick').datetimepicker({});

  var planting_project_id = $(".planting_project_id").val();
  var planting_project_name = $('input.planting_project_name').val();
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
    
    renderApplication(planting_project_id);
	renderEquipment(planting_project_id);
	renderDistribution(planting_project_id, planting_project_name);
  }
  
  // WHEN USER CHANGE THE FARM
  $("#output_task_farm_id").change(function(){
  	resetForm();
  	
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
  	resetForm();
  	
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
  	resetForm();
  	
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
  	  resetForm();
  	  return;
  	}
  	
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

		renderApplication(data.uuid);
        renderEquipment(data.uuid);
        renderDistribution(data.uuid, data.name);
      }
    });
  });

  function renderApplication(planting_project_id) {
    $('#output_task_name').empty();
    jQuery.ajax({
      url: "/get_output_application_data",
      type: "GET",
      data: {"planting_project_id" : planting_project_id},
      dataType: "json",
      success: function(data){
      	$.each(data, function(i, value) {
          $('#output_task_name').append('<option value="'+value.uuid+'">'+value.name+'</option>');
        });
      }
    });
  }
  function renderDistribution(planting_project_id, planting_project_name) {
    $('#distribution').empty();
    $('#distribution').append("<h3>Distribution - "+planting_project_name+"</h3><hr/>");
    $('#distribution').show();
    jQuery.ajax({
      url: "/get_distributions_by_planting_project",
      type: "GET",
      data: {"planting_project_id" : planting_project_id},
      dataType: "json",
      success: function(data) {
        $.each(data.distributions, function(i, value) {
          
          var result = "<div class='form-group'><label class='col-xs-3 control-label text-left'>"+ value.label +"</label>";
          var fieldReadonly = value.read_only == '1' ? 'readonly' : '';
          
          var uoms = value.uoms.split(",");
          var length = uoms.length;
          for (var i = 0; i < length; i++) {
          	result += '<div class="col-xs-3">'
			             +'<div class="input-group">'
			               +'<div class="input float required">'
			                 +'<input class="numeric float required form-control" id="distribution_'+i+'_'+value.order_of_display+'" type="number" value="0.0" step="any" '+fieldReadonly+' name="distribution_amounts[]" onchange="javascript:'+ value.function_name +'();">'
			                 +'<input type="hidden" value="'+ value.uuid +'" name="distribution_ids[]">'
			                 +'<input type="hidden" value="'+ uoms[i].split("|")[0] +'" name="uom_ids[]">'
			               +'</div>'
			               +'<span class="input-group-addon">' + uoms[i].split("|")[1] + '</span>'
			             +'</div>'
                       +'</div>';
          }
          
          if(value.to_nursery) {
          	result += '<div class="col-xs-3"><input name="to_nursery_distribution" type="hidden" value="'+value.uuid+'" /></input><select name="to_nursery_warehouses" class="form-control">';
          	
          	$.each(data.nursery_warehouses, function(i, wh) {
          	  result += '<option value=' + wh.uuid + '>' + wh.name + '</option>';
            });
            
            result += '</select></div>';
          }
          
          if(value.to_finish) {
          	result += '<div class="col-xs-3"><input name="to_finish_distribution" type="hidden" value="'+value.uuid+'" /><select name="to_finish_warehouses" class="form-control">';
          	
          	$.each(data.finish_warehouses, function(i, wh) {
          	  result += '<option value=' + wh.uuid + '>' + wh.name + '</option>';
            });
            
            result += '</select></div>';
          }
          
          result += "</div>";
          
          $('#distribution').append(result);
        });
        
        renderDistributionScript();
      }
    });
  }
  function renderDistributionScript() {
  	var functionResult = '<script>'
                          +'function coconutAutoCalc(){'
							+'var distribution_0_4 = $("#distribution_0_4").val() == "" ? 0 : $("#distribution_0_4").val();'
							+'var distribution_0_7 = $("#distribution_0_7").val() == "" ? 0 : $("#distribution_0_7").val();'
							+'var distribution_0_8 = $("#distribution_0_8").val() == "" ? 0 : $("#distribution_0_8").val();'
							+'var distribution_0_9 = $("#distribution_0_9").val() == "" ? 0 : $("#distribution_0_9").val();'
							+'var distribution_0_11 = $("#distribution_0_11").val() == "" ? 0 : $("#distribution_0_11").val();'
							+'$("#distribution_0_3").val(parseInt(distribution_0_8) + parseInt(distribution_0_9));'
							+'$("#distribution_0_2").val(parseInt($("#distribution_0_3").val()) + parseInt(distribution_0_4));'
							+'$("#distribution_0_6").val(distribution_0_11);'
							+'$("#distribution_0_5").val(parseInt($("#distribution_0_6").val()) + parseInt(distribution_0_7));'
							+'$("#distribution_0_1").val(parseInt($("#distribution_0_2").val()) + parseInt($("#distribution_0_5").val()));'
							+'$("#distribution_0_10").val(parseInt(distribution_0_4) + parseInt(distribution_0_7));'
						  +'}'
                          +'function jackfruitAutoCalc(){'
                            +'var distribution_0_3 = $("#distribution_0_3").val() == "" ? 0 : parseInt($("#distribution_0_3").val());'
							+'var distribution_1_3 = $("#distribution_1_3").val() == "" ? 0 : parseInt($("#distribution_1_3").val());'
							+'var distribution_0_4 = $("#distribution_0_4").val() == "" ? 0 : parseInt($("#distribution_0_4").val());'
							+'var distribution_1_4 = $("#distribution_1_4").val() == "" ? 0 : parseInt($("#distribution_1_4").val());'
							+'var distribution_0_5 = $("#distribution_0_5").val() == "" ? 0 : parseInt($("#distribution_0_5").val());'
							+'var distribution_1_5 = $("#distribution_1_5").val() == "" ? 0 : parseInt($("#distribution_1_5").val());'
							+'var distribution_0_6 = $("#distribution_0_6").val() == "" ? 0 : parseInt($("#distribution_0_6").val());'
							+'var distribution_1_6 = $("#distribution_1_6").val() == "" ? 0 : parseInt($("#distribution_1_6").val());'
							+'var distribution_0_7 = $("#distribution_0_7").val() == "" ? 0 : parseInt($("#distribution_0_7").val());'
							+'var distribution_1_7 = $("#distribution_1_7").val() == "" ? 0 : parseInt($("#distribution_1_7").val());'
							+'var distribution_0_8 = $("#distribution_0_8").val() == "" ? 0 : parseInt($("#distribution_0_8").val());'
							+'var distribution_1_8 = $("#distribution_1_8").val() == "" ? 0 : parseInt($("#distribution_1_8").val());'
							+'$("#distribution_0_9").val(distribution_0_5 + distribution_0_6);'
							+'$("#distribution_1_9").val(distribution_1_5 + distribution_1_6);'
							+'$("#distribution_0_2").val(distribution_0_3 + distribution_0_4 + distribution_0_5);'
							+'$("#distribution_1_2").val(distribution_1_3 + distribution_1_4 + distribution_1_5);'
							+'$("#distribution_0_1").val(distribution_0_3 + distribution_0_4 + distribution_0_5 + distribution_0_6);'
							+'$("#distribution_1_1").val(distribution_1_3 + distribution_1_4 + distribution_1_5 + distribution_1_6);'
                          +'}'
                        +'</script>';

    $('#distribution').append(functionResult);
  }
  function renderEquipment(planting_project_id) {
    //Start Get Equipment and select Equipment
    // Get data for Chosen Equipment when Planting project has data
    $('select.item-select-equipments').html('');
    $('#equipments').val("");

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
  function resetForm() {
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