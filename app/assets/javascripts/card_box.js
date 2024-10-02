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
  
  function currentRotation() {
    // use panelvar
    const computedStyle = window.getComputedStyle(panel);
    const transformMatrix = computedStyle.transform;
    let degrees;
    if (transformMatrix !== "none") {
      const values = transformMatrix.split('(')[1].split(')')[0].split(',');
      const cosine = values[0];
      const sine = values[2];
      const radians = Math.atan2(sine, cosine)
      degrees = radians * (180 / Math.PI);
      console.log(`Y rotation: ${degrees} degrees`);
    } else {
      degrees = 0;
      console.log("No Transform");
    }
    return degrees;
  }
  
  function normalizeAngle(angle) {
    return ((angle + 180) % 360) - 180;
  }
  
  function rotateForward(byDegrees) {
    let currentPosition = currentRotation();
    desiredPosition = normalizeAngle(currentPosition - byDegrees);
    console.log(`Desired: ${desiredPosition} degrees`);
    panel.style.transform = `translateZ(-165px) rotateY(${desiredPosition}deg)`;
  }
  
  function rotateBackward(byDegrees) {
    let currentPosition = currentRotation();
    desiredPosition = normalizeAngle(currentPosition + byDegrees);
    console.log(`Desired: ${desiredPosition} degrees`);
    panel.style.transform = `translateZ(-165px) rotateY(${desiredPosition}deg)`;
  }
  
  window.rotateForward = rotateForward;
  window.rotateBackward = rotateBackward;

  // setInterval(rotateBox, 10000); // Rotate every 3 seconds
});

// Remove the duplicate DOMContentLoaded event listener
