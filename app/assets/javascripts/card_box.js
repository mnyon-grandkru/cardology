$(document).on('turbolinks:load', function() {
  const panel = document.querySelector('.surface-wrapper');
  let rotation = 0;

  // $('.surface').on('click', function(event) {
  //   rotation += 90;
  //   panel.style.transform = `rotateY(${rotation}deg)`;
  // });

  function rotateBox() {
    rotation += 90;
    panel.style.transform = `translateZ(-165px) rotateY(${rotation}deg)`;
  }

  setInterval(rotateBox, 3000); // Rotate every 3 seconds
});

// Remove the duplicate DOMContentLoaded event listener
