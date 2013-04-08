$ ->
  jQuery("[data-slideshow='true']")
    .attr("rel", "slideshow")
    .fancybox
      nextClick: true
      nextEffect: 'none'
      prevEffect: 'none'
      helpers:
        title:
          type: 'inside'
