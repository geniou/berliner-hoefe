jQuery ->
  jQuery('fieldset fieldset legend').click ->
    jQuery(@).parent().toggleClass('open')
