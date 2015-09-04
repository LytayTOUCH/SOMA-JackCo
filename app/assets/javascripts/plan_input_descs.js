$(document).ready(function(){
  $("#material_other").prop('disabled', true).trigger("chosen:updated");
  
  $("#main_form").keydown(function(event){
    if(event.keyCode == 13) {
      event.preventDefault();
      return false;
    }
  });
  
  //Init Material Table Header
  var material_header ='<tr>'
                        +'<th style="text-align: center;">N<sup>o</sup></th>'
                        +'<th style="text-align: center;">Description</th>'
                        +'<th style="text-align: center;">UOM</th>'
                        +'<th style="text-align: center;">Composite Description</th>'
                        +'<th style="text-align: center;">Useful Description for Consumption</th>'
                        +'<th style="text-align: center;">Replacement App</th>'
                      +'</tr>';
  
  $(".chosen").chosen(
    {width: "100%"},
    {allow_single_deselect: true},
    {no_results_text: 'No results matched'}
  ).change(function(event, params){
    var select_id = $(this).attr("id");
    var ok_id = select_id.replace("material_", "ok_");
    $("#"+ok_id).attr("disabled", "disabled");
    if($(this).val() != null){
      $("#"+ok_id).removeAttr('disabled');
    }
  });

  $(".ok").click(function(){
    var ok_id = $(this).attr("id");
    var select_id = ok_id.replace("ok_", "material_");
    var reset_id = ok_id.replace("ok_", "reset_");
    var table_id = ok_id.replace("ok_", "table_");
    var separator_id = ok_id.replace("ok_", "separator_");
    var category = ok_id.replace("ok_", "");
    $("#"+select_id).prop('disabled', true).trigger("chosen:updated");
    $("#"+reset_id).removeAttr('disabled');
    $(this).attr("disabled", "disabled");
    var need_height = parseInt($(this).attr("need_height"));
    
    //START: Initialize Table Here
    $("#"+table_id).html("");
    $("#"+separator_id).height($("#"+select_id+"_chosen").height()+need_height);
    
    //Init Material Table Row
    var material_row = '';
    $.each(getSelectedItems(select_id), function(index, value) {
      var n = index+1;
      material_row+='<tr>'
                     +'<td style="text-align: center;vertical-align:middle;">'+n+'</td>'
                     +'<td style="vertical-align:middle;"><input type="hidden" value="'+value.split('|')[0]+'" name="l_'+category+'[]" />'+value.split('|')[0]+'</td>'
                     +'<td id="td-'+category+'-'+value.split('|')[1]+'" style="text-align: center;vertical-align:middle;"></td>'
                     +'<td style="text-align: center;vertical-align:middle;"><input class="string required form-control" type="text" name="cd_'+category+'[]" /></td>'
                     +'<td style="text-align: center;vertical-align:middle;"><input class="string required form-control" type="text" name="udc_'+category+'[]" /></td>'
                     +'<td style="text-align: center;vertical-align:middle;"><input class="string required form-control" type="text" name="ra_'+category+'[]" /></td>'
                   +'</tr>';
    });
    
    //Finalize The Table
    var table = '<table class="table table-bordered" style="box-shadow:0 5px 15px rgba(0, 0, 0, 0.5);">'
                +material_header
                +material_row
               +'</table>';
    $("#"+table_id).append(table);
    //END: Initialize Table Here
    
    //Get Selected Items' UOM
    $.each(getSelectedItems(select_id), function(index, value) {var material_id = value.split('|')[1];if(material_id!=""){jQuery.ajax({url: "/get_unit_of_measurement_data",type: "GET",data: {"material_uuid" : material_id},dataType: "json",success: function(data){$('#td-'+category+'-'+material_id).html('<input type="hidden" value="'+data.name+'" name="uom_'+category+'[]" />'+data.name);}});}});
  });
  
  $(".reset").click(function(){
    var reset_id = $(this).attr("id");
    var ok_id = reset_id.replace("reset_", "ok_");
    var select_id = reset_id.replace("reset_", "material_");
    var table_id = reset_id.replace("reset_", "table_");
    $("#"+select_id).prop('disabled', false).val("").trigger("chosen:updated");
    $("#"+ok_id).attr("disabled", "disabled");
    $(this).attr("disabled", "disabled");
    $("#"+table_id).html("");
  });
  
  $("#reset_direct_material").click(function(){
    $(this).attr("disabled", "disabled");
    $("#table_direct_material").html("");
    $("#add_direct_material").attr("count",0);
  });
  $("#add_direct_material").click(function(){
    var table_id = $(this).attr("id").replace("add_", "table_");
    var separator_id = $(this).attr("id").replace("add_", "separator_");
    var table = "";
    var count = parseInt($(this).attr("count"));
    var n = count+1;
    
    $("#"+separator_id).height(50);
    $("#reset_direct_material").removeAttr('disabled');
    
    if(count==0) {
      table += '<table class="table table-bordered" style="box-shadow:0 5px 15px rgba(0, 0, 0, 0.5);">'
                +'<tbody id="my_table">'
                +material_header
                 +'<tr>'
                   +'<td style="text-align: center;vertical-align:middle;">'+n+'</td>'
                   +'<td style="vertical-align:middle;">'+$("#planting_project_name").val()+' Seed</td>'
                   +'<td style="text-align: center;vertical-align:middle;">Unit</td>'
                   +'<td style="text-align: center;vertical-align:middle;"><input class="string required form-control" type="text" name="cd_direct_material[]" /></td>'
                   +'<td style="text-align: center;vertical-align:middle;"><input class="string required form-control" type="text" name="udc_direct_material[]" /></td>'
                   +'<td style="text-align: center;vertical-align:middle;"><input class="string required form-control" type="text" name="ra_direct_material[]" /></td>'
                 +'</tr>'
                 +'</tbody>'
               +'</table>';
               
      $(this).attr("count",n);
      $("#"+table_id).append(table);
    } else {
      $("#my_table").append('<tr>'
                   +'<td style="text-align: center;vertical-align:middle;">'+n+'</td>'
                   +'<td style="vertical-align:middle;">'+$("#planting_project_name").val()+' Seed</td>'
                   +'<td style="text-align: center;vertical-align:middle;">Unit</td>'
                   +'<td style="text-align: center;vertical-align:middle;"><input class="string required form-control" type="text" name="cd_direct_material[]" /></td>'
                   +'<td style="text-align: center;vertical-align:middle;"><input class="string required form-control" type="text" name="udc_direct_material[]" /></td>'
                   +'<td style="text-align: center;vertical-align:middle;"><input class="string required form-control" type="text" name="ra_direct_material[]" /></td>'
                 +'</tr>');
       $(this).attr("count",n);
    }
  });

  $("#txt_other").keyup(function(){$("#btn_add").attr("disabled","disabled");if($(this).val()!=""){$("#btn_add").removeAttr('disabled');}});
  $("#txt_other").keydown(function(event){if(event.keyCode == 13 && $("#txt_other").val() != "") {addOther();}});
  $("#btn_add").click(function(){addOther();});
  $("#reset_other").click(function(){
    var reset_id = "reset_other";
    var ok_id = reset_id.replace("reset_", "ok_");
    var select_id = reset_id.replace("reset_", "material_");
    var table_id = reset_id.replace("reset_", "table_");
    $("#"+select_id).text("").trigger("chosen:updated");
    $("#"+ok_id).attr("disabled", "disabled");
    $(this).attr("disabled", "disabled");
    $("#"+table_id).html("");
    $("#txt_other").focus();
  });
  function addOther(){$('#material_other').append('<option value="" selected="selected">'+$("#txt_other").val()+'</option>').trigger('chosen:updated');$("#txt_other").val("");$("#txt_other").focus();$("#btn_add").attr("disabled","disabled");var select_id = "material_other";var btn_id = select_id.replace("material_", "ok_");$("#"+btn_id).attr("disabled", "disabled");if($("#"+select_id).val() != null) {$("#"+btn_id).removeAttr('disabled');}}
  
  function getSelectedItems(strSelectId){var str="#"+strSelectId+" option:selected";var option_all=$(str).map(function(){return $(this).text()+'|'+$(this).val();}).get().join(":");return option_all.split(":");}
});
