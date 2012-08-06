$ ->
  map = new google.maps.Map(document.getElementById('map_canvas'),
    zoom: 8
    center: new google.maps.LatLng(52.459, 13.387)
    mapTypeId: google.maps.MapTypeId.ROADMAP
  )

  for location in locations
    do ->
      position = new google.maps.LatLng(location.latitude, location.longitude)
      marker = new google.maps.Marker
        position: position 
        map: map
        title: location.name

      coordInfoWindow = new google.maps.InfoWindow()
      coordInfoWindow.setContent('<a href="' + location.url + '">goto</a>')
      coordInfoWindow.setPosition(position)

      google.maps.event.addListener(marker, 'click', ->
        coordInfoWindow.open(map)
        # window.location.href = location.url
      )

