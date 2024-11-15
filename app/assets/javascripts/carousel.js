
window.owlOptions = {
  loop: true,
  margin: 0,
  responsiveClass: true,
  nav: true,
  navText: ["<span class='carousel_size'>&#60;</span>","<span class='carousel_size'>&#62;</span>"],
  smartSpeed: 700,
  responsive: {0:{items:1}, 400:{items:1}, 600:{items:1}, 1000:{items:1}}
}

window.cardReferenceToggler = function(element) {
  if ($(element).find('.owl-item.active img').length) {
    $(element).closest('.pane_guidance').find('.reading_context img').hide(800);
  } else {
    $(element).closest('.pane_guidance').find('.reading_context img').show(800);
  }
}

$(document).on('turbolinks:load', function() {
    var carousel = $('.owl-carousel');
    carousel.owlCarousel(owlOptions);
    
    carousel.on('translated.owl.carousel', function(event) {
      cardReferenceToggler(event.target);
    });
  });