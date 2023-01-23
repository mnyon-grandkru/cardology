
$(document).ready(function(){
    $('.owl-carousel').owlCarousel({
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
    })
  });