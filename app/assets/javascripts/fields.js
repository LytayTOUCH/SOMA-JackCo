// http://stackoverflow.com/questions/19487751/array-contains-latitude-and-longitude-of-a-polygon-in-google-maps-drawingmanager

$(document).ready(function() {
  var mapOptions = {
    center: new google.maps.LatLng(-34.397, 150.644),
    zoom: 8
  };

  var map = new google.maps.Map(document.getElementById('map-canvas-field'),
    mapOptions);

  var drawingManager = new google.maps.drawing.DrawingManager({
    drawingMode: google.maps.drawing.OverlayType.MARKER,
    drawingControl: true,
    drawingControlOptions: {
      position: google.maps.ControlPosition.TOP_CENTER,
      drawingModes: [
        google.maps.drawing.OverlayType.POLYGON,
      ]
    },
    circleOptions: {
      fillColor: '#ffff00',
      fillOpacity: 1,
      strokeWeight: 5,
      clickable: false,
      editable: true,
      zIndex: 1
    }
  });

  drawingManager.setMap(map);

  google.maps.event.addDomListener(drawingManager, 'polygoncomplete', function(polygon) {
    var polygonBounds = polygon.getPath();
    var coordinates = [];
    for(var i = 0 ; i < polygonBounds.length ; i++) {
      coordinates.push(polygonBounds.getAt(i).lat(), polygonBounds.getAt(i).lng());
    }
    $('#form-model-field').modal();
  });
});
