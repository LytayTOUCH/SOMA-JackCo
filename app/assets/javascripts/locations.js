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
      var farm_id = $(".farm_id").val();

      jQuery.ajax({
        url: "/get_render_child",
        type: "GET",
        data: { "stage_id" : stage_id, "farm_id" : farm_id },
        dataType: "html",
        success: function(data) {
          $(".production-status *").remove();
          $(".production-status").append(data)
        }
      });
    }
  );
});