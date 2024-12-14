// app/javascript/application.js
import { Application } from "@hotwired/stimulus";

import jQuery from 'jquery'
import '@rails/ujs'
import 'jquery-validation'
import 'js-routes'
import 'owl.carousel'
import 'moment'

import { rotatePast, rotateFuture, rotateTo, rotateOctagon } from "./behaviors/card_box.js"
import { flipCardBack, flipBoxBack, flipPlanetBack, flipOctagonBack } from "./behaviors/flipback.js"
import { owlOptions, cardReferenceToggler, initializeCarousel } from "./behaviors/carousel.js"

// Make jQuery available globally
window.jQuery = jQuery
window.$ = jQuery

// Make functions globally available if needed
window.rotatePast = rotatePast;
console.log(window.rotatePast)
window.rotateFuture = rotateFuture;
window.rotateTo = rotateTo;
window.rotateOctagon = rotateOctagon;
window.flipCardBack = flipCardBack;
window.flipBoxBack = flipBoxBack;
window.flipPlanetBack = flipPlanetBack;
window.flipOctagonBack = flipOctagonBack;
window.owlOptions = owlOptions;
window.cardReferenceToggler = cardReferenceToggler;

import WheelController from "./controllers/wheel_controller.js"
const application = Application.start();
application.register("wheel", WheelController)

export { application };
