export function flipCardBack(event) {
  $(event.currentTarget).closest('.panel').toggleClass('flip');
  return $(event.currentTarget).closest('.delivery_zone').toggleClass('add_height');
}

export function flipBoxBack(event) {
  return $(event.currentTarget).closest('.surface-wrapper').css('transform', 'translateZ(-165px) rotateY(180deg)');
}

export function flipPlanetBack(event) {
  $(event.currentTarget).closest('.surface-wrapper').css('transform', 'translateZ(-165px) rotateY(180deg)');
  return $(event.currentTarget).closest('.surface-wrapper').find('.alpha').html($('#planet_back_config').data('planet-back-image'));
}

export function flipOctagonBack(event) {
  return $(event.currentTarget).closest('.surface-wrapper').css('transform', 'translateZ(-165px) rotateY(0deg)');
}

window.flipCardBack = flipCardBack;
window.flipBoxBack = flipBoxBack;
window.flipPlanetBack = flipPlanetBack;
window.flipOctagonBack = flipOctagonBack;
