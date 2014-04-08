jQuery ->
  jQuery('fieldset legend').click ->
    jQuery(@).parent().toggleClass('open')
