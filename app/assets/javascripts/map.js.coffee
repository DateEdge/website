# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
maxZoom = 12
$ ->
  if (typeof(google) != "undefined")
    $("#map").css(height: $(window).height() - 75)

    initialize = ->

      styles = [{
        textColor: 'white',
        url: $("#map").data("small-icon"),
        height: 55,
        width: 56
      }, {
        textColor: 'white',
        url: $("#map").data("medium-icon"),
        height: 55,
        width: 56
      }, {
        textColor: 'white',
        url: $("#map").data("large-icon"),
        height: 55,
        width: 56
      }]

      options = {maxZoom: maxZoom, styles: styles}

      myLatLng = $("#map").data('current-lat-lng')
      myLatLng ||= [-34.397, 150.644]
      latLng = new google.maps.LatLng(myLatLng[0], myLatLng[1])
      mapOptions = {
        center: latLng,
        zoom: 6,
        maxZoom: maxZoom
      }
      map = new google.maps.Map(document.getElementById("map"),mapOptions);
      mc = new MarkerClusterer(map, [], options);

      google.maps.event.addListener mc, 'clusterclick', (cluster) ->
        if mc.map.zoom == maxZoom
          content = ""
          console.log content
          $.each cluster.getMarkers(), (i, marker) ->
            console.log marker
            content += " & "  unless i == 0
            content += marker.infowindow.content

          marker = cluster.getMarkers()[0]
          marker.infowindow.content = content
          marker.infowindow.open(map, marker)

      data = $("#map").data('lat-lngs')
      for lat in data
        latLng = new google.maps.LatLng(lat[0], lat[1])
        addMarker(latLng, mc, map, lat[2])


    google.maps.event.addDomListener(window, 'load', initialize);


    addMarker = (latLng, mc, map, username) ->
      infowindow = new google.maps.InfoWindow {
        content: "<span class='username'>" + username + "</span>"
      }

      marker = new google.maps.Marker {
        position: latLng,
        username: username,
        infowindow: infowindow
      }

      google.maps.event.addListener marker, 'click', ->
        infowindow.open(map,marker)

      mc.addMarker marker
