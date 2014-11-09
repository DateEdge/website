# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
maxZoom = 12
window.dateEdge = {}
template = $('#js-user-card').html()

resizeMap = ->
  $("#map").css(height: $(window).height() - 60)

$ ->
  if (typeof(google) != "undefined")

    resizeMap()
    $(window).resize ->
      resizeMap()

    initialize = ->
      window.dateEdge.markers = {}
      window.dateEdge.infowindow = new google.maps.InfoWindow { content: ""}

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

      data = $("#map").data('lat-lngs')
      for lat in data
        latLng = new google.maps.LatLng(lat[0], lat[1])
        user = {
          username: lat[2],
          avatar: lat[3],
          location: lat[4],
          user_id: lat[5]
        }
        addMarker(latLng, map, user)

      mc = new MarkerClusterer(map, window.dateEdge.markers, options);

      google.maps.event.addListener map, 'click', ->
        if !window.dateEdge.openCluster
          window.dateEdge.infowindow.close()
        window.dateEdge.openCluster = false

      google.maps.event.addListener mc, 'clusterclick', (cluster) ->
        if mc.map.zoom == maxZoom
          content = ""
          $.each cluster.getMarkers(), (i, marker) ->
            content += marker.content

          marker = cluster.getMarkers()[0]
          window.dateEdge.openCluster = true
          window.dateEdge.infowindow.content = infoWindowContent(content)
          latLng = new google.maps.LatLng(marker.position.lat(), marker.position.lng())
          window.dateEdge.infowindow.setPosition(latLng)
          window.dateEdge.infowindow.open(map)

      $(".user-filter").change () ->
        User.where($(".filter")).then (users) ->
          markers = []
          mc.clearMarkers()
          $.each users, (index, user) ->
            marker = window.dateEdge.markers[user.id]
            if marker then mc.addMarker(marker)

    google.maps.event.addDomListener(window, 'load', initialize);


    infoWindowContent = (content) ->
      "<ul class='js-user-container info-window'>" + content + "</ul>"

    addMarker = (latLng, map, user) ->
      Mustache.parse(template)
      rendered = Mustache.render(template, user);

      marker = new google.maps.Marker {
        position: latLng,
        content: rendered,
        user_id: user.user_id
      }
      window.dateEdge.markers[user.user_id] = marker

      google.maps.event.addListener marker, 'click', ->
        window.dateEdge.infowindow.content = infoWindowContent(marker.content)
        window.dateEdge.infowindow.open(map,marker)
