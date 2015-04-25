
$(document).ready(function() {

  $('.farm_id').data('old_farm_id', $('input.hidden#plan_farm_uuid').val());

  $('.farm_id').change(function() {
    $('#plan_farm_for_year > option').removeAttr('selected');
    $('#plan_farm_for_year > option:first').attr('selected', true);

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
    // if ($('.farm_id').data('old_farm_id') == ""){
      var stage_id = $(".stage-list").val();
      
      if (stage_id == "") {
        $(".render-block *").remove();
        return;
      }

      var farm_id = $(".farm_id").val();
      var phase_id = $(".phase_id").val();
      var for_year = $("#plan_farm_for_year").val();

      jQuery.ajax({
        url: "/get_render_block",
        type: "GET",
        data: { "stage_id" : stage_id,
                "farm_id" : farm_id,
                "phase_id" : phase_id,
                "for_year" : for_year },
        dataType: "html",
        success: function(data) {
          // var edit_farm_id = "";
          
          // if ($('.farm_id').data('old_farm_id') == ""){
          //   edit_farm_id = $('.farm_id').data('old_farm_id');
          // }

          $(".plan_locations *").remove();
          $(".plan_locations").html(data);

          // if (edit_farm_id == ""){
          //   $('.farm_id').data('old_farm_id', edit_farm_id);
          //   // $('form div').append("<input name='_method' type='hidden' value='patch'>");
          //   // $('form').removeAttr("action");
          //   // $('form').attr("action", "/plan_farms" + edit_farm_id);
          //   // $('input.btn.btn-primary').removeAttr("value");
          //   // $('input.btn.btn-primary').attr("value", "Update Plan farm");
          // }

          stage1();
          phase1();
          farm1();
          move_dom_style();
        }
      });
    // }
  });

  move_dom_style();

  function stage1(){
    $('.stage-list').change(function() {
      // if ($('.farm_id').data('old_farm_id') == ""){
        var stage_id = $(".stage-list").val();
        
        if (stage_id == "") {
          $(".render-block *").remove();
          return;
        }
        
        var farm_id = $(".farm_id").val();
        var phase_id = $(".phase_id").val();
        var for_year = $("#plan_farm_for_year").val();

        jQuery.ajax({
          url: "/get_render_block",
          type: "GET",
          data: { "stage_id" : stage_id,
                  "farm_id" : farm_id,
                  "phase_id" : phase_id,
                  "for_year" : for_year },
          dataType: "html",
          success: function(data) {
            // var edit_farm_id = "";
            
            // if ($('.farm_id').data('old_farm_id') == ""){
            //   edit_farm_id = $('.farm_id').data('old_farm_id');
            // }

            $(".plan_locations *").remove();
            $(".plan_locations").html(data);

            // if (edit_farm_id == ""){
            //   $('.farm_id').data('old_farm_id', edit_farm_id);
            //   // $('form div').append("<input name='_method' type='hidden' value='patch'>");
            //   // $('form').removeAttr("action");
            //   // $('form').attr("action", "/plan_farms/" + $('.farm_id').data('old_farm_id'));
            //   // $('input.btn.btn-primary').removeAttr("value");
            //   // $('input.btn.btn-primary').attr("value", "Update Plan farm");
            // }
            stage2();
            phase2();
            farm2();
            move_dom_style();
          }
        });
      // }
    });
  }

  function stage2(){
    $('.stage-list').change(function() {
      // if ($('.farm_id').data('old_farm_id') == ""){
        var stage_id = $(".stage-list").val();
        
        if (stage_id == "") {
          $(".render-block *").remove();
          return;
        }

        var farm_id = $(".farm_id").val();
        var phase_id = $(".phase_id").val();
        var for_year = $("#plan_farm_for_year").val();

        jQuery.ajax({
          url: "/get_render_block",
          type: "GET",
          data: { "stage_id" : stage_id,
                  "farm_id" : farm_id,
                  "phase_id" : phase_id,
                  "for_year" : for_year },
          dataType: "html",
          success: function(data) {
            // var edit_farm_id = "";
            
            // if ($('.farm_id').data('old_farm_id') == ""){
            //   edit_farm_id = $('.farm_id').data('old_farm_id');
            // }

            $(".plan_locations *").remove();
            $(".plan_locations").html(data);

            // if (edit_farm_id == ""){
            //   $('.farm_id').data('old_farm_id', edit_farm_id);
            //   // $('form div').append("<input name='_method' type='hidden' value='patch'>");
            //   // $('form').removeAttr("action");
            //   // $('form').attr("action", "/plan_farms/" + $('.farm_id').data('old_farm_id'));
            //   // $('input.btn.btn-primary').removeAttr("value");
            //   // $('input.btn.btn-primary').attr("value", "Update Plan farm");
            // }
            stage1();
            phase1();
            farm1();
            move_dom_style();
          }
        });
      // }
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
      $('#plan_farm_for_year > option').removeAttr('selected');
      $('#plan_farm_for_year > option:first').attr('selected', true);

      $('.phase_id > option').removeAttr('selected');
      $('.phase_id > option:first').attr('selected', true);

      $(".stage-list").find("option:gt(0)").remove();

      $(".render-block *").remove();
      farm2();
    });
  }

  function farm2(){
    $('.farm_id').change(function() {
      $('#plan_farm_for_year > option').removeAttr('selected');
      $('#plan_farm_for_year > option:first').attr('selected', true);

      $('.phase_id > option').removeAttr('selected');
      $('.phase_id > option:first').attr('selected', true);

      $(".stage-list").find("option:gt(0)").remove();

      $(".render-block *").remove();
      farm1();
    });
  }

  // $("#new_plan_farm").click(function(event){
  //   var error_free = true;
    
  //   var element = $("#plan_farm_farm_id");
  //   var valid = element.hasClass("error");
  //   if (!valid){element.removeClass("error").addClass("error_show"); error_free=false;}
  //   else{element.removeClass("error_show").addClass("error");}
  //   if (!error_free){ event.preventDefault();}

  // });

  // $('#new_plan_farm select').on('input', function() {
  //   var input=$(this);
  //   var is_name=input.val();
  //   if(is_name){input.removeClass("error_show").addClass("error");}
  //   else{input.removeClass("error").addClass("error_show");}
  // });


  function move_dom_style(){
    var max_status = parseInt($('.max-status-count').first().text());
    console.log(max_status);

    for ( var i = 0; i < max_status; i++ ) {
      $(".block-status-" + i + " .row.tab-zone-block ul.nav.nav-tabs").append($(".remark-" + i + " li"));
      $(".block-status-" + i + " .row.plan-status-new-row").append($(".plan-production-status-tag label.text-status-" + i));
      $(".block-status-" + i + " .row.tab-zone-block .tab-content").append($("div.remark.remark-" + i + " div.tab-pane"));
      $(".block-status-" + i + " .row.plan-status-remark").append($("div.remark.remark-" + i));
    }

    // $(".render-block1 .row.tab-zone-block .nav-tabs").append($(".remark-1 li"));
    // $(".render-block1 .row.plan-status-new-row").append($(".plan-production-status-tag label.text-status-1"));
    // $(".render-block1 .row.tab-zone-block .tab-content").append($("div.remark.remark-1 div.tab-pane"));
    // $(".render-block1 .row.plan-status-remark").append($("div.remark.remark-1"));
    
    // $('.remark#0').append($('.tab-content.0'));
    // $('.remark#0 .tab-content.0').append($('div.tab-pane#tab-zone-0'));    

    // $('.remark#1').append($('.tab-content.1'));
    // $('.remark#1 .tab-content.1').append($('div.tab-pane#tab-zone-1'));

  }

});