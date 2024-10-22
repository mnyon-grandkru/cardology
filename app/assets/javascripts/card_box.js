$(document).on('turbolinks:load', function() {
  function currentRotation(panel) {
    let computedStyle = window.getComputedStyle(panel);
    let transformMatrix = computedStyle.transform;
    let degrees;
    if (transformMatrix !== "none") {
      let values = transformMatrix.split('(')[1].split(')')[0].split(',');
      console.log(`Values: ${values}`);
      let a = parseFloat(values[0]);
      let b = parseFloat(values[8]);
      let radians = Math.atan2(b, a);
      degrees = radians * (180 / Math.PI);
      // console.log(`Y rotation: ${degrees} degrees`);
    } else {
      degrees = 0;
      console.log("No Transform");
    }
    return degrees;
  }
  
  function normalizeAngle(angle) {
    return angle; //((angle + 180) % 360) - 180;
  }
  
  function rotatePast(byDegrees) {
    let panel = event.target.closest('.surface-wrapper');
    let currentPosition = currentRotation(panel);
    let desiredPosition = normalizeAngle(currentPosition - byDegrees);
    // console.log(`Desired: ${desiredPosition} degrees`);
    panel.style.transform = `translateZ(calc(var(--half-card-box-width) * -1)) rotateY(${desiredPosition}deg)`;
  }
  
  function rotateFuture(byDegrees) {
    let panel = event.target.closest('.surface-wrapper');
    let currentPosition = currentRotation(panel);
    let desiredPosition = normalizeAngle(currentPosition + byDegrees);
    // console.log(`Desired: ${desiredPosition} degrees`);
    panel.style.transform = `translateZ(calc(var(--half-card-box-width) * -1)) rotateY(${desiredPosition}deg)`;
  }
  
  function rotateOctagon() {
    let panel = document.querySelector('.eight_sided_box .surface-wrapper');
    let currentPosition = currentRotation(panel);
    let desiredPosition = normalizeAngle(currentPosition + 45);
    panel.style.transform = `translateZ(calc(var(--half-card-box-width) * -1)) rotateY(${desiredPosition}deg)`;
  }
  
  window.rotatePast = rotatePast;
  window.rotateFuture = rotateFuture;
  window.rotateOctagon = rotateOctagon;
});
