$(document).ready(function() {
  return $("#calendar").fullCalendar({
    editable: true,
    
    header: {
      left: "prev,next today",
      center: "title",
      right: "month,agendaWeek,agendaDay"
    },
    default: true,
    defaultView: "month",
    height: 500,
    slotMinutes: 30,

    eventSources: [
      {
        url: "/activities"
      }
    ],
    timeFormat: "h:mm t{ - h:mm t} ",
    dragOpacity: "0.5",

    eventDrop: function(event, dayDelta, minuteDelta, allDay, revertFunc) {
      return updateEvent(event);
    },

    eventResize: function(event, dayDelta, minuteDelta, revertFunc) {
      // return updateEvent(event);
      alert('Hello');
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