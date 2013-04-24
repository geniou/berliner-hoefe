$ ->
  # calculate map center
  center =
    latitude:
      max: null
      min: null
      get_dif: -> center.latitude.max - center.latitude.min
    longitude:
      max: null
      min: null
      get_dif: -> center.longitude.max - center.longitude.min
    add: (latitude, longitude) ->
      center.latitude.max = latitude if center.latitude.max is null or latitude > center.latitude.max
      center.longitude.max = longitude if center.longitude.max is null or longitude > center.longitude.max
      center.latitude.min = latitude if center.latitude.min is null or latitude < center.latitude.min
      center.longitude.min = longitude if center.longitude.min is null or longitude < center.longitude.min
    get: (a) ->
      if center[a].min is null
        app.config.map.default.center[a]
      else
        center[a].min + (center[a].get_dif() / 2)
    get_latitude: -> center.get('latitude')
    get_longitude: -> center.get('longitude')

  ###
    marker icon
  ###
  get_icon = (marker_type = 'active') ->
    new google.maps.MarkerImage(
      app.config.map.marker.images[marker_type],
      new google.maps.Size(app.config.map.marker.size.width, app.config.map.marker.size.height),
      new google.maps.Point(app.config.map.marker.origin.x, app.config.map.marker.origin.y),
      new google.maps.Point(app.config.map.marker.anchor.x, app.config.map.marker.anchor.y)
    )

  ###
    add maker for given location to map
  ###
  add_marker = (location, map) ->
    center.add(location.latitude, location.longitude)
    position = new google.maps.LatLng(location.latitude, location.longitude)

    icon = get_icon(if location.additional then 'inactive')
    icon_hover = get_icon()

    marker = new google.maps.Marker
      position: position
      map: map
      icon: icon

    info = new InfoBox(
      content: "<div class='name'>#{location.name}</div>"
      alignBottom: true
      pixelOffset: new google.maps.Size(-80, -45)
      closeBoxURL: ""
      disableAutoPan: true
    )

    google.maps.event.addListener(marker, 'click', ->
      window.location.href = location.url
    )

    label = jQuery('[data-locationid='+location.id+']')
    google.maps.event.addListener(marker, 'mouseover', ->
      info.open(map, marker)
      marker.setIcon(icon_hover)
      label.addClass('highlighted')
    )
    google.maps.event.addListener(marker, 'mouseout', ->
      info.close()
      marker.setIcon(icon)
      label.removeClass('highlighted')
    )

    label.hover(
      -> info.open(map, marker),
      -> info.close()
    )

  # create map with markers
  $('#map').each ->
    map = new google.maps.Map(@,
      zoom: app.config.map.default.zoom
      mapTypeId: google.maps.MapTypeId.ROADMAP
    )

    # given locations
    locations = app.map.locations || []
    add_marker(location, map) for location in locations
    add_marker(location, map) for location in app.map.nearby if app.map.nearby?

    # set center
    map.setCenter(new google.maps.LatLng(center.get_latitude(), center.get_longitude()))

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
          google.maps.event.addListener(newMarker, 'dragend', (event) ->
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
