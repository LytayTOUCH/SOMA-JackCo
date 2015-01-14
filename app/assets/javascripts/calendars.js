$(document).on('ready page:load',function() {
  return $("#calendar").fullCalendar({
    editable: true,
    droppable: true,
    
    header: {
      left: "prev,next today",
      center: "title",
      right: "month,agendaWeek,agendaDay"
    },

    default: true,
    defaultView: "month",
    height: 600,
    slotMinutes: 30,

    eventSources: [{
      url: "/activities"
    }],

    eventRender: function(activity, element){ 
      element.find('.fc-event-title').append(" " + activity.note); 
      element.height(30);
    },

    timeFormat: "h:mm t{ - h:mm t} ",
    dragOpacity: "0.5",

    eventDrop: function(event, dayDelta, minuteDelta, allDay, revertFunc) {
      return updateEvent(event);
    },

    eventResize: function(event, dayDelta, minuteDelta, revertFunc) {
      return updateEvent(event);
      // alert('Hello');
    },

    dayClick: function(date, jsEvent, view) {
      var myDate = new Date();
      myDate.setDate(date.getDate());
      $('#current-date').val(myDate);

      window.location = "/activities/new?current_date="+myDate;

      // $('#myModal').modal('hide');
      // $('#myModal').addClass('fade');
      // $('#myModal').modal('show');
    },

    eventClick: function(event, element) {
      // window.location = "/activities/edit/"+activity.uuid;
      // $('#calendar').fullCalendar('updateEvent', event);
    },

    updateEvent: function(activity) {
      return $.update("/activities/" + activity.uuid, {
        event: {
          title: activity.activity_type_uuid,
          starts_at: "" + activity.starts_at,
          note: activity.note
        }
      });
    }
  });
});