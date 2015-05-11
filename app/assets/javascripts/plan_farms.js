$(document).ready(function() {
  showLoading();

  function showLoading() {
    $('#plan-location-loading-indicator').hide();
    $(document)
      .ajaxStart(function() {
        $('#plan-location-loading-indicator').show();
      })
      .ajaxStop(function() {
        $('#plan-location-loading-indicator').hide();
    });
  }

  $('.farm_id').change(function() {

    $('.planting_project_id > option').removeAttr('selected');
    $('.planting_project_id > option:first').attr('selected', true);

    $('.phase_id > option').removeAttr('selected');
    $('.phase_id > option:first').attr('selected', true);

    $(".stage-list").find("option:gt(0)").remove();

    $(".render-block *").remove();
  });

  $('.phase_id').change(function() {
    var phase_id = $(".phase_id").val();
    jQuery.ajax({
      url: "/get_production_stages",
      type: "GET",
      data: { "phase_id" : phase_id },
      dataType: "json",
      success: function(data) {
        $(".stage-list").find("option:gt(0)").remove();
        $(".render-block *").remove();

        $.each(data, function(i, value) {
          $(".stage-list").append("<option value=" + value.uuid + ">" + value.name + "</option>");
        });
      }
    });
  });

  $('.stage-list').change(function() {
      var stage_id = $(".stage-list").val();
      
      if (stage_id == "") {
        $(".render-block *").remove();
        return;
      }

      var farm_id = $(".farm_id").val();
      var phase_id = $(".phase_id").val();
      var for_year = $("#plan_farm_for_year").val();
      var planting_project_id = $(".planting_project_id").val();

      jQuery.ajax({
        url: "/get_render_block",
        type: "GET",
        data: { "stage_id" : stage_id,
                "farm_id" : farm_id,
                "phase_id" : phase_id,
                "for_year" : for_year,
                "planting_project_id" : planting_project_id },
        dataType: "html",
        success: function(data) {

          $(".plan_locations *").remove();
          $(".plan_locations").html(data);

          stage1();
          phase1();
          farm1();
        }
      });
  });

  function stage1(){
    $('.stage-list').change(function() {
        var stage_id = $(".stage-list").val();
        
        if (stage_id == "") {
          $(".render-block *").remove();
          return;
        }
        
        var farm_id = $(".farm_id").val();
        var phase_id = $(".phase_id").val();
        var for_year = $("#plan_farm_for_year").val();
        var planting_project_id = $(".planting_project_id").val();

        jQuery.ajax({
          url: "/get_render_block",
          type: "GET",
          data: { "stage_id" : stage_id,
                  "farm_id" : farm_id,
                  "phase_id" : phase_id,
                  "for_year" : for_year,
                  "planting_project_id" : planting_project_id },
          dataType: "html",
          success: function(data) {

            $(".plan_locations *").remove();
            $(".plan_locations").html(data);

            stage2();
            phase2();
            farm2();
            showLoading();
          }
        });
    });
  }

  function stage2(){
    $('.stage-list').change(function() {
        var stage_id = $(".stage-list").val();
        
        if (stage_id == "") {
          $(".render-block *").remove();
          return;
        }

        var farm_id = $(".farm_id").val();
        var phase_id = $(".phase_id").val();
        var for_year = $("#plan_farm_for_year").val();
        var planting_project_id = $(".planting_project_id").val();

        jQuery.ajax({
          url: "/get_render_block",
          type: "GET",
          data: { "stage_id" : stage_id,
                  "farm_id" : farm_id,
                  "phase_id" : phase_id,
                  "for_year" : for_year,
                  "planting_project_id" : planting_project_id },
          dataType: "html",
          success: function(data) {

            $(".plan_locations *").remove();
            $(".plan_locations").html(data);

            stage1();
            phase1();
            farm1();
            showLoading();
          }
        });
    });
  }

  function phase1(){
    $('.phase_id').change(function() {
      var phase_id = $(".phase_id").val();
      jQuery.ajax({
        url: "/get_production_stages",
        type: "GET",
        data: { "phase_id" : phase_id },
        dataType: "json",
        success: function(data) {
          $(".stage-list").find("option:gt(0)").remove();
          $(".render-block *").remove();

          $.each(data, function(i, value) {
            $(".stage-list").append("<option value=" + value.uuid + ">" + value.name + "</option>");
          });
        }
      });
    });
  }

  function phase2(){
    $('.phase_id').change(function() {
      var phase_id = $(".phase_id").val();
      jQuery.ajax({
        url: "/get_production_stages",
        type: "GET",
        data: { "phase_id" : phase_id },
        dataType: "json",
        success: function(data) {
          $(".stage-list").find("option:gt(0)").remove();
          $(".render-block *").remove();

          $.each(data, function(i, value) {
            $(".stage-list").append("<option value=" + value.uuid + ">" + value.name + "</option>");
          });
        }
      });
    });
  }

  function farm1(){
    $('.farm_id').change(function() {
      $('.planting_project_id > option').removeAttr('selected');
      $('.planting_project_id > option:first').attr('selected', true);

      $('.phase_id > option').removeAttr('selected');
      $('.phase_id > option:first').attr('selected', true);

      $(".stage-list").find("option:gt(0)").remove();

      $(".render-block *").remove();
      farm2();
    });
  }

  function farm2(){
    $('.farm_id').change(function() {
      $('.planting_project_id > option').removeAttr('selected');
      $('.planting_project_id > option:first').attr('selected', true);

      $('.phase_id > option').removeAttr('selected');
      $('.phase_id > option:first').attr('selected', true);

      $(".stage-list").find("option:gt(0)").remove();

      $(".render-block *").remove();
      farm1();
    });
  }

});