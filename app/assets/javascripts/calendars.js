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
        url: "/events"
      }
    ],
    timeFormat: "h:mm t{ - h:mm t} ",
    dragOpacity: "0.5",

    eventDrop: function(event, dayDelta, minuteDelta, allDay, revertFunc) {
      return updateEvent(event);
    },

    eventResize: function(event, dayDelta, minuteDelta, revertFunc) {
      return updateEvent(event);
    },

    dayClick: function(date, jsEvent, view) {
      $('#myModal').modal('hide');
      $('#myModal').addClass('fade');
      $('#myModal').modal('show');

      var myDate = new Date();
      myDate.setDate(date.getDate());
      $('#current-date').val(myDate);
    },

    updateEvent: function(activity) {
      return $.update("/events/" + activity.id, {
        event: {
          title: activity.activity_type.name,
          date: "" + activity.date,
          note: activity.note
        }
      });
    }

  });

});