$(document).on('turbolinks:load', function() {
  function currentRotation(panel) {
    const computedStyle = window.getComputedStyle(panel);
    const transformMatrix = computedStyle.transform;
    let degrees;
    if (transformMatrix !== "none") {
      const values = transformMatrix.split('(')[1].split(')')[0].split(',');
      const cosine = values[0];
      const sine = values[2];
      const radians = Math.atan2(sine, cosine)
      degrees = radians * (180 / Math.PI);
      // console.log(`Y rotation: ${degrees} degrees`);
    } else {
      degrees = 0;
      console.log("No Transform");
    }
    return degrees;
  }
  
  function normalizeAngle(angle) {
    return ((angle + 180) % 360) - 180;
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
