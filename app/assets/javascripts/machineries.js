  $(document).ready(function() {
    if($("#machinery_source")[0].selectedIndex==1) {
      $('#machinery_planting_project_id').prop('disabled', false);
    } else {
      $("#machinery_planting_project_id").val("");
      $('#machinery_planting_project_id').prop('disabled', 'disabled');
    }
        
    $('#machinery_source').change(
      function() {
        if($("#machinery_source")[0].selectedIndex==1) {
          $('#machinery_planting_project_id').prop('disabled', false);
        } else {
          $("#machinery_planting_project_id").val("");
          $('#machinery_planting_project_id').prop('disabled', 'disabled');
        }
      }
    );
  });
  
  function previewFile() {
    var preview = document.querySelector('img');
    var file    = document.querySelector('input[type=file]').files[0];
    var reader  = new FileReader();
  
    reader.onloadend = function () {
      preview.src = reader.result;
    };
  
    if (file) {
      reader.readAsDataURL(file);
    } else {
      preview.src = "";
    }
  }