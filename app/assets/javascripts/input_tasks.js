$(document).ready(function(){
	$('.machinery-name').hide();
	$('.material-name').hide();
	$('.block_id').change(function() {

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
              )  
            }
          });

          //Start Get Equipment and select Equipment
          // Get data for Chosen Equipment when Planting project has data
          $('select.item-select-equipments').html('');
          // $('.warehouse').show();
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
              )  
            }
          });

          

        }

			});

		}
	);

  //Equipment
  $('select.item-select-equipments').change(function(event, params){              

    // Creating a row of Machinery when data from chosen
    if(event.target == this){
      console.log($(this).val());
      $('#equipments').val($(this).val());
      var equipment_id = params.selected;
      console.log(equipment_id);
      
    }
  });
  // End Equipment

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
      beforeSend: function(){
        
      },
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
          str +=      '<span id="material_select_msg-'+params.selected+'" style="color: red;"></span>';
          str +=    '</div>';
          str +=    '<label class="col-xs-1 control-label">Qty*</label>';
          str +=    '<div class="col-xs-2 material-qtys">';
          str +=      '<div class="input-group">';
          str +=        '<input type="number" name="material_qtys_of_machinery[]" class="form-control material-qty" id="material_qty_request-'+params.selected+'" value="0.0"></input>';
          str +=        '<span class="input-group-addon uom-name-' + params.selected + '">';
          str +=        '</span>';
          str +=      '</div>';
          str +=      '<span id="material_amount_msg-'+params.selected+'" style="color: red;"></span>';
          str +=    '</div>';

          
          str +=  '</div>';
          str += '</div>';
          
          $('div.machinery-name').append(str);

          $('select.warehouse-select-'+params.selected).append('<option value></option>');
          $.each(data.warehouse, function(i, value) {
            $('select.warehouse-select-'+params.selected).append('<option value=' + value.uuid + '>' + value.name + '</option></select>');
          });

          $('select.material-select-'+params.selected).append('<option value></option>');
          $.each(data.material, function(i, value) {
            $('select.material-select-'+params.selected).append('<option value='+ value.uuid +'>' + value.name + '</option>');
          });

          // Start validate warehouses_of_machinery selection
          $("#warehouse_select-"+params.selected).focusout(function(){

            if ($("#warehouse_select-"+params.selected).val() ==  "") {
              $("#warehouse_select_msg-"+params.selected).text("Warehouse can't be blank. ");
                
            }else{
              $("#warehouse_select_msg-"+params.selected).empty();
            }
              
          });
          // End validate warehouses_of_machinery selection

          // Start validate materials_of_machinery selection
          $("#material_select-"+params.selected).focusout(function(){

            if ($("#material_select-"+params.selected).val() ==  "") {
              $("#material_select_msg-"+params.selected).text("Material can't be blank. ");
                
            }else{
              $("#material_select_msg-"+params.selected).empty();
            }
              
          });
          // End validate materials_of_machinery selection

          // Start Validate Material Quantity when focusout (Machinery choosen)
          $("#material_qty_request-"+params.selected).focusout(function(){
            var warehouse_id = $(".warehouse-select-"+params.selected).val();
            var material_id = $(".material-select-"+params.selected).val();
            jQuery.ajax({
              url: "/find_amount",
              type: "GET",
              data: {"warehouse_id" : warehouse_id, "material_id" : material_id},
              dataType: "json",
              success: function(data) {
                // data is quantity in stock

                console.log("Amount in stock:");
                console.log(data);

                if ($("#material_qty_request-"+params.selected).val() ==  "") {
                  $("#material_amount_msg-"+params.selected).text("Quantity can't be blank. ");
                }else if($("#material_qty_request-"+params.selected).val() <= data){
                  $("#material_amount_msg-"+params.selected).empty();

                }else if($("#material_qty_request-"+params.selected).val() > data){
                  $("#material_amount_msg-"+params.selected).text("Requested Quantity is out of stock. " + "Quantity in stock has only " + data);

                }else{

                }

              }
            });
              
          });
          // End Validate Material Quantity when focusout (Machinery choosen)

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
          beforeSend: function(){

          },
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
              str +=      '<span id="warehouse_select_material_msg-'+params.selected+'" style="color: red;"></span>';
              str +=    '</div>';
              
              str +=    '<label class="col-xs-1 control-label">Qty*</label>';
              str +=    '<div class="col-xs-2 material-qtys">';
              str +=      '<div class="input-group">';
              str +=        '<input type="number" name="material_qtys_of_material[]" class="form-control material-qty" id="materials_qty_request-'+params.selected+'" value="0.0"></input>';
              str +=        '<span class="input-group-addon uom-name">';
              str +=          data.material_uom.name;
              str +=        '</span>';
              str +=      '</div>';
              str +=      '<span id="materials_amount_msg-'+params.selected+'" style="color: red;"></span>';
              str +=    '</div>';
              
              str +=  '</div>';
              str += '</div>';
              
              $('div.material-name').append(str);

              $('select.warehouse-select-material-'+params.selected).append('<option value></option>');
              $.each(data.warehouse, function(i, value) {
                $('select.warehouse-select-material-'+params.selected).append('<option value=' + value.uuid + '>' + value.name + '</option></select>');
              });

              // Start validate warehouses_of_material selection
              $("#warehouse_select_material-"+params.selected).focusout(function(){

                if ($("#warehouse_select_material-"+params.selected).val() ==  "") {
                  $("#warehouse_select_material_msg-"+params.selected).text("Warehouse can't be blank. ");
                    
                }else{
                  $("#warehouse_select_material_msg-"+params.selected).empty();
                }
                  
              });
              // End validate warehouses_of_material selection

              // Start Validate Material Quantity when focusout (Material choosen)
              $("#materials_qty_request-"+params.selected).focusout(function(){
                var warehouse_id = $(".warehouse-select-material-"+params.selected).val();
                var material_id = material_uuid;
                jQuery.ajax({
                  url: "/find_amount",
                  type: "GET",
                  data: {"warehouse_id" : warehouse_id, "material_id" : material_id},
                  dataType: "json",
                  success: function(data) {
                    // data is quantity in stock

                    console.log("Amount in stock:");
                    console.log(data);

                    if ($("#materials_qty_request-"+params.selected).val() ==  "") {
                      $("#materials_amount_msg-"+params.selected).text("Quantity can't be blank. ");
                    }else if($("#materials_qty_request-"+params.selected).val() <= data){
                      $("#materials_amount_msg-"+params.selected).empty();

                    }else if($("#materials_qty_request-"+params.selected).val() > data){
                      $("#materials_amount_msg-"+params.selected).text("Requested Quantity is out of stock. " + "Quantity in stock has only " + data);

                    }else{

                    }

                  }
                });
                  
              });
              // End Validate Material Quantity when focusout (Material choosen)

            }

          }); 
        }

		}
	);	

});