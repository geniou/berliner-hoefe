$ ->
  map = null
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
    get_zoom: -> 13 # todo

  get_icon = (marker_type) ->
    new google.maps.MarkerImage(
      app.config.map.marker[marker_type],
      new google.maps.Size(21, 30),
      new google.maps.Point(0,0),
      new google.maps.Point(0, 30)
    )

  add_marker = (location) ->
    center.add(location.latitude, location.longitude)
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
      mapTypeId: google.maps.MapTypeId.ROADMAP
    )

    locations = app.map.locations || []
    add_marker(location) for location in locations
    add_marker(location, {additional: true}) for location in app.map.nearby if app.map.nearby?

    # set center
    map.setCenter(new google.maps.LatLng(center.get_latitude(), center.get_longitude()))
    map.setZoom(center.get_zoom()) if locations.length == 1

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
