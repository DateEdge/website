# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  if (typeof(google) != "undefined")
    $("#map").css(height: $(window).height() - 75)

    initialize = ->

      myLatLng = $("#map").data('current-lat-lng')
      myLatLng ||= [-34.397, 150.644]
      latLng = new google.maps.LatLng(myLatLng[0], myLatLng[1])
      mapOptions = {
        center: latLng,
        zoom: 6,
        maxZoom: 12
      }
      map = new google.maps.Map(document.getElementById("map"),mapOptions);
      mc = new MarkerClusterer(map);

      data = $("#map").data('lat-lngs')
      for lat in data
        console.log lat
        latLng = new google.maps.LatLng(lat[0], lat[1])
        addMarker(latLng, mc, map, lat[2])


    google.maps.event.addDomListener(window, 'load', initialize);

    addMarker = (latLng, mc, map, username) ->
      marker = new google.maps.Marker {
        position: latLng
      }

      infowindow = new google.maps.InfoWindow {
        content: "<h1>" + username + "</h1>"
      }

      google.maps.event.addListener marker, 'click', ->
        infowindow.open(map,marker)

      mc.addMarker marker
