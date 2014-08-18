# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("#map").css(height: $(window).height() - 75)

  initialize = ->

    latLng = new google.maps.LatLng(-34.397, 150.644)
    mapOptions = {
      center: latLng,
      zoom: 6
    }
    map = new google.maps.Map(document.getElementById("map"),mapOptions);
    mc = new MarkerClusterer(map);

    data = (n for n in [1..10])
    for n in data
      latLng = new google.maps.LatLng(-34.397 + n/5, 150.644 - n/10)
      addMarker(latLng, mc)


  google.maps.event.addDomListener(window, 'load', initialize);

  addMarker = (latLng, mc) ->
    marker = new google.maps.Marker {
      position: latLng
    }
    mc.addMarker marker
