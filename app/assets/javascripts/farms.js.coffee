ready = ->
  initialize = ->
    farm_latlong = $('.farm-latlong').text().split(", ")
    mapOptions = 
      zoom: 14
      center: new (google.maps.LatLng)(parseFloat(farm_latlong[0]), parseFloat(farm_latlong[1]))
      streetViewControl: false
      panControl: false
    map = new (google.maps.Map)(document.getElementById('blocks-map'), mapOptions)

    polypoints = []
    points = [
      [
        11.342527
        104.817818
      ]
      [
        11.338278
        104.819578
      ]
      [
        11.339287
        104.814707
      ]
    ]
    for i in points by 1
      polypoints.push new (google.maps.LatLng)(i[0], i[1])
    console.log polypoints

    Triangle = new (google.maps.Polygon)(
      paths: polypoints
      strokeColor: '#126c00'
      strokeOpacity: 0.8
      strokeWeight: 1
      fillColor: '#99FF84'
      fillOpacity: 0.35)

    Triangle.setMap map

  initialize()

  $('.btn-test').click ->
    alert($('.farm-latlong').text());

  $('.btn-add').click ->
    loading_box = """
      <div aria-hidden="false" aria-labelledby="myModalLabel" class="modal fade in" data-backdrop="static" data-keyboard="false" id="myModalLoading" role="dialog" tabindex="-1" style="display: block;">
        <div class="modal-dialog modal-sm">
          <div class="alert alert-success" role="alert">
            <div class= "row">
                <p class = "text-center">
                  <img class = "text-center" alt="Logo" src="/assets/loader.gif">
                  <br>
                  Loading ...
                </p>
            </div>
          </div>
        </div>
      </div>
                  """
    $('.form-modal').html(loading_box);
    $('#myModalLoading').modal('show');
  
$(document).ready ready
$(document).on 'page:load', ready

$ ->
  $.rails.allowAction = (link) ->
    return true unless link.attr('data-confirm')
    $.rails.showConfirmDialog(link) 
    false 

  $.rails.confirmed = (link) ->
    link.removeAttr('data-confirm')
    link.trigger('click.rails')

  $.rails.showConfirmDialog = (link) ->
    message = link.attr 'data-confirm'
    html = """
            <div class="modal" id="confirmationDialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
            <div class="modal-dialog modal-sm">
              <div class="modal-content">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                  <h4 class="modal-title icon-red"><b><i class="fa fa-exclamation-triangle fa-lg"> </i> Confirmation !<b></h4>
                </div>
                <div class="modal-body">
                  <h4 class = "text-center">#{message}</h4>
                </div>
                <div class="modal-footer">
                  <a data-dismiss="modal" class="btn btn-default">#{link.data('cancel')}</a>
                  <a data-dismiss="modal" class="btn btn-danger confirm">#{link.data('ok')}</a>
                </div>
              </div>
            </div>
          </div>
           """
    $(html).modal()
    $('#confirmationDialog .confirm').on 'click', -> $.rails.confirmed(link)