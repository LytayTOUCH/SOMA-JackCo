$(document).ready(function() {
  $('.block_id').change(function(){
    block = $(".block_id").val();
    $('#plan_farm_plan_phases_attributes_0_plan_farm_id').attr('value', block);
  });

  $('.phase_id').change(
      function() {
        var phase_id = $(".phase_id").val();
        jQuery.ajax({
          url: "/get_production_stages",
          type: "GET",
          data: { "phase_id" : phase_id },
          dataType: "json",
          success: function(data) {
            $(".stage-list").find("option:gt(0)").remove();

            $.each(data, function(i, value) {
              $(".stage-list").append("<option value=" + value.uuid + ">" + value.name + "</option>");
            });
          }
        });
      }
    );

  $('.stage-list').change(
      function() {
        var stage_id = $(".stage-list").val();
        jQuery.ajax({
          url: "/get_production_statuses",
          type: "GET",
          data: { "stage_id" : stage_id },
          dataType: "json",
          success: function(data) {
            $(".production-status *").remove();
            $.each(data, function(i, value) {
              $(".production-status").append("<div style='padding-top: 10px;'" +
               " class='row'><div class='status-" + i + "' >" +
               " <input class='hidden' id='plan_farm_plan_phases_attributes_0_plan_production_stages_attributes_0_plan_production_statuses_attributes_" + i + "_production_status_id'" +
               " name='plan_farm[plan_phases_attributes][0][plan_production_stages_attributes][0][plan_production_statuses_attributes][" + i + "][production_status_id]' type='hidden' value=" + value.uuid + ">" +               
               " <label class='col-md-1' " +
               " style='padding-top: 20px;' value= " + value.uuid + ">" + value.name + "</label> </div></div>")

              var block_id = $(".block_id").val();
              jQuery.ajax({
              url: "/get_areas_by_farm",
              type: "GET",
              data: { "farm_id" : block_id, "status_line" : i },
              dataType: "html",
              success: function(data) {
                jQuery(".status-" + i).append(data)
                }
              });
            });
          }
        });
      
      }
    );
});