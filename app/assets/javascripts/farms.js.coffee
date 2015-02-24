ready = ->
  
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