$(document).ready(function(){
	$('.machinery-name').hide();
	$('.material-name').hide();
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

		      		
      		//Start Get Machinery and select Machinery
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
              ).change(function(event, params){
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
                  beforeSend: function(){
                    if(params.selected) {
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
                      str +=      '<select name="warehouses_of_machinery[]" class="warehouse-select form-control">';
                      str +=      '</select>';
                      str +=    '</div>';
                      str +=    '<label class="col-xs-1 control-label">Material</label>';
                      str +=    '<div class="col-xs-2">';
                      str +=      '<select name="materials_of_machinery[]" class="material-select form-control">';
                      str +=      '</select>';
                      str +=    '</div>';
                      str +=    '<label class="col-xs-1 control-label">Qty</label>';
                      str +=    '<div class="col-xs-1">';
                      str +=      '<input name="material_qtys_of_machinery[]" class="form-control material-qty"></input>';
                      str +=    '</div>';
                      
                      str +=  '</div>';
                      str += '</div>';
                      
                      $('div.machinery-name').append(str);

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
            }
          });
        }
		    //Finish

			});

		}
	);

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
                  beforeSend: function(){
                    if(params.selected) {
                      $('.warehouse-select').empty();
                    }
                  },
                  dataType: "json",
                    success: function(data){
                      var str = "";
                      str += '<div id="material-' + material_uuid + '">';
                      str +=  '<div class="form-group">';                      
                      str +=    '<label class="col-xs-2 control-label">';
                      str +=      data.material_name.name;
                      str +=    '</label>'
                      str +=    '<label class="col-xs-1 control-label">Warehouse</label>';
                      str +=    '<div class="col-xs-2">';
                      str +=      '<select name="warehouses_of_material[]" class="warehouse-select form-control">';
                      str +=      '</select>';
                      str +=    '</div>';
                      
                      str +=    '<label class="col-xs-1 control-label">Qty</label>';
                      str +=    '<div class="col-xs-2">';
                      str +=      '<div class="input-group">';
                      str +=        '<input name="material_qtys_of_material[]" class="form-control material-qty"></input>';
                      str +=        '<span class="input-group-addon uom-name">';
                      str +=          data.material_uom.name;
                      str +=        '</span>';
                      str +=      '</div>';
                      str +=    '</div>';
                      
                      str +=  '</div>';
                      str += '</div>';
                      
                      $('div.material-name').append(str);

                      $.each(data.warehouse, function(i, value) {
                        $('select.warehouse-select').append('<option value=' + value.uuid + '>' + value.name + '</option></select>');
                      });

                    }
                  }); 
                }

		}
	);	

});