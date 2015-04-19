$(document).ready(function() {
  $('.farm_id').change(function(){
    var farm_id = $(".farm_id").val();
    $('#plan_farm_plan_phases_attributes_0_plan_farm_id').attr('value', farm_id);

    jQuery.ajax({
      url: "/get_zone_by_farm",
      type: "GET",
      data: { "farm_id" : farm_id },
      dataType: "json",
      success: function(data) {
        $(".zone-list").find("option:gt(0)").remove();

        $.each(data, function(i, value) {
          $(".zone-list").append("<option value=" + value.uuid + ">" + value.name + "</option>");
        });
      }
    });
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
               " class='row'>" +
               " <input class='hidden' id='plan_farm_plan_phases_attributes_0_plan_production_stages_attributes_0_plan_production_statuses_attributes_" + i + "_production_status_id'" +
               " name='plan_farm[plan_phases_attributes][0][plan_production_stages_attributes][0][plan_production_statuses_attributes][" + i + "][production_status_id]' type='hidden' value=" + value.uuid + ">" +               
               " <label class='col-md-4' " +
               " value= " + value.uuid + ">" + (i + 1) + ". " + value.name + "</label></div>")

              $(".production-status").append("<div class='status-" + i + "' style='padding-left: 10px'></div>")

              var zone_list = $(".zone-list").val();
              jQuery.ajax({
              url: "/get_areas_by_zone",
              type: "GET",
              data: { "zone_id" : zone_list, "status_line" : i },
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

  $( ".stage-list" ).change();


});