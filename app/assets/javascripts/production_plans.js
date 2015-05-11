$(document).ready(function() {
  $('.planting_project_id').change(function(){
    var pid = $(".planting_project_id").val();
    var year = $(".year_selected").val();

    $.ajax({
      url: "/get_production_classification",
      type: "GET",
      data: { "pid" : pid, "y" : year },
      dataType: "html",
      success: function(data) {
        $(".production-classification *").remove();
        $(".production-classification").html(data);

        planting1();
      }
    });
  });

  function planting1(){
    $('.planting_project_id').change(function(){
      var pid = $(".planting_project_id").val();
      var year = $(".year_selected").val();

      $.ajax({
        url: "/get_production_classification",
        type: "GET",
        data: { "pid" : pid, "y" : year },
        dataType: "html",
        success: function(data) {
          $(".production-classification *").remove();
          $(".production-classification").html(data);

          planting2();

        }
      });
    });
  }

  function planting2(){
    $('.planting_project_id').change(function(){
      var pid = $(".planting_project_id").val();
      var year = $(".year_selected").val();

      $.ajax({
        url: "/get_production_classification",
        type: "GET",
        data: { "pid" : pid, "y" : year },
        dataType: "html",
        success: function(data) {
          $(".production-classification *").remove();
          $(".production-classification").html(data);

          planting1();
        }
      });
    });
  }

});