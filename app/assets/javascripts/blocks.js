/*ready = ->
  
$(document).ready ready
$(document).on 'page:load', ready

$ ->
  $.rails.allowAction = (link) ->*/

(function() {
  var ready;

  ready = function() {};

  $(document).ready(ready);

  $(document).on('page:load', ready);

  $(function() {
    return $.rails.allowAction = function(link) {};
  });

}).call(this);