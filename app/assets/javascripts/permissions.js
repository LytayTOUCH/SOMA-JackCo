var ready = function() {
	$('input').click(function(){
		var permission_id = $(this).attr("id");
		var access = $(this).attr("value");
		var value = $(this).attr("checked") || 0;

		// alert(permission_id + ", " + access + ", " + value);

		$.ajax({
			url: "update",
	        type: "PATCH",
	        data: {id:permission_id, access:value},
    	}).done(function(msg){
    		console.log(msg);
    	}).fail(function(msg) {
			console.log(msg);
		}).always(function(msg) {
	    	console.log(msg);
	  	});
	});
};


$(document).ready(ready);
$(document).on('page:load', ready);