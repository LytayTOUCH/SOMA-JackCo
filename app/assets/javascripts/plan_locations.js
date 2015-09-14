$(document).ready(function(){
  $("#main_form").keydown(function(event){
    if(event.keyCode == 13) {
      event.preventDefault();
      return false;
    }
  });
  
  jQuery.ajax({
    url: "/get_project_farm_data",
    type: "GET",
    data: {"planting_project_id" : $('#planting_project_id').val()},
    dataType: "json",
    success: function(data){
      var table_header = initTableHeader(data);
      
      jQuery.ajax({
        url: "/get_location_plan_phase_data",
        type: "GET",
        data: {"planting_project_id" : $('#planting_project_id').val()},
        dataType: "json",            
        success: function(data) {
          var table_body = initTableBody(data, table_header[1]);
          
          $("#table").append('<table style="box-shadow:0 5px 15px rgba(0, 0, 0, 0.5);" class="table table-bordered">'+table_header[0]+table_body+'</table>');
          $("#table").append(initScript());
        }
      });
    }
  });
  
  function initScript(){
    var retVal = '<script>'
                    +'function calTotalRow(location_colspan, row_index) {'
                      +'var tree_val = 0;'
                      +'for(var i=0;i<location_colspan;i++){'
                        +'tree_val += parseInt($("#txt_"+row_index+"_"+i).val()==""? 0 : $("#txt_"+row_index+"_"+i).val());'
                      +'}'
                      +'$("#span_"+row_index).val(tree_val);'
                    +'}'
                +'</script>';
    
    return retVal;
  }
  function initTableHeader(data){
    var location_colspan = 0;
    var farm_row = "";
    var zone_row = "";
    var area_row = "";
    
    $.each(data, function(i, farm_val){
      var farm_colspan = 0;
      
      $.each(farm_val.zones, function(i, zone_val){
        zone_row += '<th style="text-align:center;" colspan="'+zone_val.areas.length+'">'+zone_val.name+'</th>';
        farm_colspan += zone_val.areas.length;
        
        $.each(zone_val.areas, function(i, area_val){
          area_row += '<th style="text-align:center;"><input type="hidden" name="area[]" value="'+area_val.uuid+'">'+area_val.name+'</th>';
        });
      });
      
      farm_row += '<th style="text-align:center;" colspan="'+farm_colspan+'">'+farm_val.name+'</th>';
      location_colspan += farm_colspan;
    });
    
    var location_row = '<th style="text-align:center;" colspan="'+location_colspan+'">Location</th>';
    
    //location_row = <th colspan='10'>Location</th>
    //farm_row = <th colspan="9">Chamkar Doung Farm</th><th colspan="1">Otaroit Farm</th>
    //zone_row = <th colspan="3">Zone-I</th><th colspan="2">Zone-II</th><th colspan="2">Zone-III</th><th colspan="2">Zone-V</th><th colspan="1">Zone-IV</th>
    //area_row = <th>A</th><th>B</th><th>C</th><th>D</th><th>E</th><th>F</th><th>G</th><th>I</th><th>J</th><th>H</th>
    
    var table_header = '<tr style="background-color:#eee;">'
                        +'<th style="text-align:center;vertical-align:middle;" rowspan="4">Production Classification</th>'
                        +'<th style="text-align:center;vertical-align:middle;" rowspan="4">Production Status</th>'
                        +'<th style="text-align:center;vertical-align:middle;" rowspan="4">UOM</th>'
                        +location_row
                        +'<th style="text-align:center;vertical-align:middle;" rowspan="4">Total</th>'
                        +'<th style="text-align:center;vertical-align:middle;" rowspan="4">Spacing (m)</th>'
                        +'<th style="text-align:center;vertical-align:middle;" rowspan="4">Remarks</th>'
                      +'</tr>'
                      +'<tr style="background-color:#eee;">'
                        +farm_row
                      +'</tr>'
                      +'<tr style="background-color:#eee;">'
                        +zone_row
                      +'</tr>'
                      +'<tr style="background-color:#eee;">'
                        +area_row
                      +'</tr>';
  
    return [table_header, location_colspan];
  }
  function initTableBody(data, location_colspan){
    var phase_row = "";
    var row_index = 0;
    var phase_colspan = parseInt(location_colspan)+6;
    
    $.each(data, function(i, phase_val){
      phase_row += '<tr style="background-color:#ffff00;">'
                    +'<td colspan="'+ phase_colspan +'">'+phase_val.name+'</td>'
                  +'</tr>';
      
      $.each(phase_val.location_plan_stages, function(j, stage_val){
        
        $.each(stage_val.location_plan_statuses, function(k, status_val){
          if(k==0){
            phase_row += '<tr>'
                          +'<td style="vertical-align:middle;" rowspan="'+stage_val.location_plan_statuses.length+'">'+stage_val.name+'</td>';
          } else {
            phase_row += '<tr>';
          }
          phase_row += '<td>'+status_val.name+'</td>'
                      +'<td style="text-align:center;">Tree</td>'
                      +'REPLACE_THIS_WITH_LOCATION'
                      +'<td class="col-xs-1"><input type="text" id="span_'+row_index+'" name="total[]" class="string required form-control" style="text-align:center;" value="0" readonly></td>'
                      +'<td class="col-xs-1"><input type="text" name="spacing[]" class="string required form-control" style="text-align:center;"></td>'
                      +'<td><input type="text" name="remark[]" class="string required form-control" style="width: 150px;"></td>';
          
          phase_row += '</tr>';
          phase_row = initLocationRow(phase_row, location_colspan, row_index);
          
          row_index+=1;
        });
        
      });
    });
    
    return phase_row;
  }
  function initLocationRow(phase_row, location_colspan, row_index){
    var location_row='';
    for(var i=0;i<location_colspan;i++){
      var id = 'txt_'+row_index+'_'+i;
      location_row+='<td class="col-xs-1">'
                     +'<input type="text" name="tree_value[]" id="'+id+'" class="string required form-control" style="text-align:right;" onblur="javascript:calTotalRow('+location_colspan+','+row_index+');" value="0">'
                   +'</td>';
    }
    return phase_row.replace("REPLACE_THIS_WITH_LOCATION",location_row);
  }
});
