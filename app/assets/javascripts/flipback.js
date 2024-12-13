window.flipCardBack = function(event) {
  $(event.currentTarget).closest('.panel').toggleClass('flip');
  return $(event.currentTarget).closest('.delivery_zone').toggleClass('add_height');
};

window.flipBoxBack = function(event) {
  return $(event.currentTarget).closest('.surface-wrapper').css('transform', 'translateZ(-165px) rotateY(180deg)');
};

window.flipPlanetBack = function(event) {
  $(event.currentTarget).closest('.surface-wrapper').css('transform', 'translateZ(-165px) rotateY(180deg)');
  return $(event.currentTarget).closest('.surface-wrapper').find('.alpha').html($('#planet_back_config').data('planet-back-image'));
};

window.flipOctagonBack = function(event) {
  return $(event.currentTarget).closest('.surface-wrapper').css('transform', 'translateZ(-165px) rotateY(0deg)');
};