$ ->
  $('.map').each ->
    container = jQuery('<div />').appendTo(jQuery(this))
    map = new google.maps.Map(container[0],
      zoom: app.config.map.default.zoom
      center: new google.maps.LatLng(app.config.map.default.center.latitude, app.config.map.default.center.longitude)
      mapTypeId: google.maps.MapTypeId.ROADMAP
    )

    locations = app.map.locations || []
    for location in locations
      do (location) ->
        position = new google.maps.LatLng(location.latitude, location.longitude)

        icon = new google.maps.MarkerImage(
          app.config.map.marker[location.marker],
          new google.maps.Size(21, 30),
          new google.maps.Point(0,0),
          new google.maps.Point(0, 30)
        )

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
