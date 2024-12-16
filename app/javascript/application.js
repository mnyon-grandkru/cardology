// app/javascript/application.js
import { Application } from "@hotwired/stimulus";

import jQuery from 'jquery'
import '@rails/ujs'
import 'jquery-validation'
import 'owl.carousel'
import 'moment'

// import.meta.glob("behaviors/*.js");

// import { rotatePast, rotateFuture, rotateTo, rotateOctagon } from "./behaviors/card_box.js"
// import { flipCardBack, flipBoxBack, flipPlanetBack, flipOctagonBack } from "./behaviors/flipback.js"
// import { owlOptions, cardReferenceToggler, initializeCarousel } from "./behaviors/carousel.js"

// Make jQuery available globally
window.jQuery = jQuery
window.$ = jQuery

console.log("Loading application.js");

import { rotatePast, rotateFuture, rotateTo, rotateOctagon } from "./behaviors"
console.log("After import, rotatePast is:", typeof rotatePast);

// Make functions globally available
Object.assign(window, {
  rotatePast,
  rotateFuture,
  rotateTo,
  rotateOctagon
});

console.log("After Object.assign, window.rotatePast is:", typeof window.rotatePast);

// Add a check to verify functions are attached
console.log("Rotation functions loaded:", {
  rotatePast: !!window.rotatePast,
  rotateFuture: !!window.rotateFuture,
  rotateTo: !!window.rotateTo,
  rotateOctagon: !!window.rotateOctagon
});

// import WheelController from "./controllers/wheel_controller.js"
const application = Application.start();
application.register("wheel", WheelController)

export { application };
