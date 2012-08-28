$ ->
  map = null

  get_icon = (marker_type) ->
    new google.maps.MarkerImage(
      app.config.map.marker[marker_type],
      new google.maps.Size(21, 30),
      new google.maps.Point(0,0),
      new google.maps.Point(0, 30)
    )

  add_marker = (location) ->
    position = new google.maps.LatLng(location.latitude, location.longitude)

    marker_type = if location.additional != true then location.marker else 'additional'
    icon = get_icon(marker_type)
    icon_hover = get_icon(location.marker)

    marker = new google.maps.Marker
      position: position
      map: map
      title: location.name
      icon: icon

    info = new InfoBox(
      content: '<a href="' + location.url + '">goto</a>'
      alignBottom: true
      pixelOffset: new google.maps.Size(0, -40)
    )

    google.maps.event.addListener(marker, 'click', ->
      # info.open(map, marker)
      window.location.href = location.url
    )

    google.maps.event.addListener(marker, 'mouseover', ->
      marker.setIcon(icon_hover)
    )
    google.maps.event.addListener(marker, 'mouseout', ->
      marker.setIcon(icon)
    )

  $('.map').each ->
    container = jQuery('<div />').appendTo(jQuery(this))
    map = new google.maps.Map(container[0],
      zoom: app.config.map.default.zoom
      center: new google.maps.LatLng(app.config.map.default.center.latitude, app.config.map.default.center.longitude)
      mapTypeId: google.maps.MapTypeId.ROADMAP
    )

    locations = app.map.locations || []
    add_marker(location) for location in locations
    
    add_marker(location, {additional: true}) for location in app.map.nearby if app.map.nearby?
    if locations.length  == 1
      location = locations[0]
      map.setCenter(new google.maps.LatLng(location.latitude, location.longitude))
      map.setZoom(12)

    # edit form
    if $('#location_latitude').length == 1
      newMarker = undefined
      latitudeInput = $('#location_latitude')
      longitudeInput = $('#location_longitude')
      latitude = latitudeInput.val()
      longitude = longitudeInput.val()

      updateInput = (latLng) ->
        latitudeInput.val(latLng.lat())
        longitudeInput.val(latLng.lng())

      updateMarkerPosition = (latLng) ->
        # create or update maker
        if !newMarker?
          newMarker = new google.maps.Marker
            position: latLng
            map: map
            draggable: true
          google.maps.event.addListener(newMarker, 'dragged', (event) ->
            updateInput(event.latLng)
          )
        else
          newMarker.setPosition(latLng)

      # check for existing marker (edit)
      if latitude != '' and longitude != ''
        updateMarkerPosition(new google.maps.LatLng(latitude, longitude))

      google.maps.event.addListener(map, 'click', (event) ->
        updateMarkerPosition(event.latLng)
        updateInput(event.latLng)
      )
