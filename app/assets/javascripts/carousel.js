
$(document).ready(function(){
    $('.owl-carousel').owlCarousel({
        loop:true,
        margin:0,
        responsiveClass:true,
        nav:true,
        navText:["<span class='hello1'>&#60;</span>","<span class='hello1'>&#62;</span>"],
        smartSpeed: 1400,
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