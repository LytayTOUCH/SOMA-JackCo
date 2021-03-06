//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require dataTables/jquery.dataTables
//= require nprogress
//= require nprogress-turbolinks
//= require turbolinks
//= require moment
//= require bootstrap-datetimepicker
//= require chosen-jquery
//= require blocks
//= require farms
//= require infobox
//= require select2
//= require jquery.print-preview

$('.datatable').DataTable({
  "sPaginationType": "bootstrap"
});

$(document).ready(function() {
  NProgress.configure({
    showSpinner: false,
  });
  NProgress.start();
});

function getCenter(shape){
  var polygonCoords = [];
  $.each(shape.getPaths().getArray()[0].j, function(key, latlng){
      polygonCoords.push(new google.maps.LatLng(latlng.A, latlng.F));
  });
  var bounds = new google.maps.LatLngBounds(), i;
  for (i = 0; i < polygonCoords.length; i++) {
    bounds.extend(polygonCoords[i]);
  }
  return centerlatlong = new google.maps.LatLng(bounds.getCenter().A,bounds.getCenter().F);
}

var getPolygonPoints = function (shape_latlong){
  var polypoints = [];
  for(i=0;i<shape_latlong.length;i++){
    polypoints.push(new google.maps.LatLng(shape_latlong[i][0],shape_latlong[i][1]));
  }
  return polypoints;
};

var getCenterLatlngPolygon = function(polypoints){
  var bounds = new google.maps.LatLngBounds();
  for (i = 0; i < polypoints.length; i++) {
    bounds.extend(polypoints[i]);
  }
  return bounds.getCenter();
};
var blocks = [];
var showBlock = function(id, shape_latlong, project_name){
  var stroke_color =  "#126c00", fill_color;
  var poly_latlng_center = getCenterLatlngPolygon(getPolygonPoints(shape_latlong));
  var poly_latlng = getPolygonPoints(shape_latlong);
  switch (project_name) {
      case "coconut":
          stroke_color =  "#5EFF4A";
          fill_color = "#5EFF4A";
          break;
      case "jackfruit":
          stroke_color = "#FFCC00";
          fill_color = "#FFCC00";
          break;
      case "lemon":
          stroke_color =  "#99FF33";
          fill_color = "#99FF33";
          break;
      case "mango":
          stroke_color = "#FFFF00";
          fill_color = "#FFFF00";
          break;
  }
  block = new google.maps.Polygon({
    paths: poly_latlng,
    strokeColor: stroke_color,
    strokeOpacity: 0.8,
    strokeWeight: 1,
    fillColor: fill_color,
    fillOpacity: 0.35
  });
  block.id = id;
  blocks.push(block);
  block.setMap(map);
};
var labels=[];
var showBlockName = function(block_name, block_shape, block_id){
  var myOptions = {
    content: block_name
    ,boxStyle: {
       border: "0px solid white"
      ,textAlign: "center"
      ,fontSize: "8pt"
      ,fontWeight: "bold"
      ,color: "white"
      ,width: "60px"
     }
    ,pixelOffset: new google.maps.Size(-25, -10)
    ,position: getCenterLatlngPolygon(getPolygonPoints(block_shape))
    ,disableAutoPan: true
    ,closeBoxURL: ""
    ,isHidden: false
    ,pane: "floatPane"
    ,enableEventPropagation: true
  };
  var ibLabel = new InfoBox(myOptions);
  ibLabel.id = block_id;
  labels.push(ibLabel);
  ibLabel.open(map);
  addListenersOnPolygon(block, block_name, getCenterLatlngPolygon(getPolygonPoints(block_shape)), block_id);
};
var addListenersOnPolygon = function(polygon, block_name, center_latlong, block_id) {
  google.maps.event.addListener(polygon, 'click', function (event){
    infobox.close();
    infobox.setContent("<div class = 'col-lg-12'><div class ='col-lg-7'>"+$("#block_"+block_id).get()[0].innerHTML+"</div><div class='col-lg-5'><div style='padding: 10px 0px 0px 0px;'>"+ $('div.weather-temp').get()[0].innerHTML+"</div></div></div>");
    infobox.setPosition(center_latlong);
    infobox.open(map);
  });
};
