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

    data = $("#map").data('lat-lngs')
    for lat in data
      latLng = new google.maps.LatLng(lat[0], lat[1])
      console.log lat
      addMarker(latLng, mc, map, lat[2])


  google.maps.event.addDomListener(window, 'load', initialize);

  addMarker = (latLng, mc, map, username) ->
    marker = new google.maps.Marker {
      position: latLng,
      title: "Blah"
    }

    infowindow = new google.maps.InfoWindow {
      content: username
    }

    google.maps.event.addListener marker, 'click', ->
      infowindow.open(map,marker)

    mc.addMarker marker
