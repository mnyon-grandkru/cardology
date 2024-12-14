function currentRotation(panel) {
  let computedStyle = window.getComputedStyle(panel);
  let transformMatrix = computedStyle.transform;
  let degrees;
  if (transformMatrix !== "none") {
    let values = transformMatrix.split('(')[1].split(')')[0].split(',');
    // console.log(`Values: ${values}`);
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
  return ((angle + 180) % 360) - 180;
}

function recordPanelRotation(panel, degrees) {
  panel.dataset.rotation = parseInt(degrees);
}

export function rotatePast(byDegrees) {
  let panel = event.target.closest('.surface-wrapper');
  let currentPosition = parseInt(panel.dataset.rotation) || currentRotation(panel);
  let desiredPosition = currentPosition - byDegrees;
  recordPanelRotation(panel, desiredPosition);
  panel.style.transform = `translateZ(calc(var(--half-card-box-width) * -1)) rotateY(${desiredPosition}deg)`;
}

export function rotateFuture(byDegrees) {
  let panel = event.target.closest('.surface-wrapper');
  let currentPosition = parseInt(panel.dataset.rotation) || currentRotation(panel);
  let desiredPosition = currentPosition + byDegrees;
  recordPanelRotation(panel, desiredPosition);
  panel.style.transform = `translateZ(calc(var(--half-card-box-width) * -1)) rotateY(${desiredPosition}deg)`;
}

export function rotateTo(degrees) {
  let panel = event.target.closest('.surface-wrapper');
  recordPanelRotation(panel, degrees);
  panel.style.transform = `translateZ(calc(var(--half-card-box-width) * -1)) rotateY(${degrees}deg)`;
}

function surfaceForAngle(angle) {
  // Normalize negative angles to positive (e.g., -45 becomes 315)
  const normalizedAngle = ((angle % 360) + 360) % 360;
  
  const surfacesByAngle = {
    0: '.alpha',
    45: '.beta',
    90: '.gamma',
    135: '.delta',
    180: '.epsilon',
    225: '.zeta',
    270: '.eta',
    315: '.theta'
  };
  return surfacesByAngle[360 -normalizedAngle];
}

export function rotateOctagon(byDegrees) {
  const panel = document.querySelector('.eight_sided_box .surface-wrapper');
  let currentPosition = currentRotation(panel);
  console.log(`Current: ${currentPosition}`);
  let desiredPosition = normalizeAngle(currentPosition + byDegrees);
  
  let outgoingSurface = panel.querySelector(surfaceForAngle(currentPosition));
  console.log(`Outgoing: ${surfaceForAngle(currentPosition)}`);
  let incomingSurface = panel.querySelector(surfaceForAngle(desiredPosition));
  console.log(`Incoming: ${surfaceForAngle(desiredPosition)}`);

  panel.style.transform = `translateZ(calc(var(--half-card-box-width) * -0.92388)) rotateY(${desiredPosition}deg)`;
  outgoingSurface.style.transform = `rotateY(${360 - currentPosition}deg) translateZ(var(--octagon-z-index))`;
  incomingSurface.style.transform = `rotateY(${360 - desiredPosition}deg) translateZ(var(--octagon-z-index-front))`;
}

window.rotateOctagon = rotateOctagon;
window.rotatePast = rotatePast;
window.rotateFuture = rotateFuture;
window.rotateTo = rotateTo;
