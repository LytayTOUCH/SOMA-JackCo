$(document).ready(function(){
	$('.block_id').change(
		function() {
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
		}
	);
	
	$('.material_uuid').change(
	    function() {
	      $('.uom-name').show();
	      var material_uuid = $(".material_uuid").val();
	      jQuery.ajax({
	        url: "/get_unit_of_measurement_data",
	        type: "GET",
	        data: {"material_uuid" : material_uuid},
	        dataType: "json",
	        success: function(data){
	          $("span.uom-name").html(data.name);
	        }
	      });      
	    }
	);
});