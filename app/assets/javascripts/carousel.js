
$(document).ready(function(){
  var carousel = $('.owl-carousel');
    carousel.owlCarousel({
        loop:true,
        margin:0,
        responsiveClass:true,
        nav:true,
        navText:["<span class='carousel_size'>&#60;</span>","<span class='carousel_size'>&#62;</span>"],
        smartSpeed: 700,
        responsive:{
            0:{
                items:1
                  },
            400:{
                items:1
                },
            600:{
                items:1
                },
            1000:{
                items:1
                }
        }
    });
    
    carousel.on('changed.owl.carousel', function(event) {
      var element = event.target;
      var item = event.item.index;
      if (item == 5) {
        $(element).closest('.pane_guidance').find('.reading_context img').show(800);
      }
    });
    
  });