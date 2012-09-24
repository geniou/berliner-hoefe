$ ->
  jQuery("[data-slideshow='true']")
    .attr("data-fancybox-group", "slideshow")
    .fancybox
      nextClick: true
      openEffect: 'none'
      closeEffect: 'none'
