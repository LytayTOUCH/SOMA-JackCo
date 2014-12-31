//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require nprogress
//= require nprogress-turbolinks
//= require bootstrap/modal
//= require bootstrap/scrollspy
//= require bootstrap/dropdown
//= require select2
//= require fullcalendar
//= require moment
//= require calendars
//= require bootstrap-datetimepicker

$(document).ready(function() {
  NProgress.start();

  $("#delete-modal").on('hidden.bs.modal', function () {
    $(this).data('bs.modal', null);
	});
});

