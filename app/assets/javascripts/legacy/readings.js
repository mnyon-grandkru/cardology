$(document).on('turbo:load', function() {
  setInterval(resizeReading, 50);
  attachFlippers();
  $('#upgrade_button').on('click', function(event) {
    $('#first_card_panel').toggleClass('flip');
    return event.preventDefault();
  });
  return $('#new_birthday').on('submit', function(event) {
    var formData;
    if ($('#reading_type').val() === 'Personality Card') {
      event.preventDefault();
      formData = $(this).serialize();
      return $.ajax({
        url: '/guidances/show?prompt=true',
        method: 'POST',
        data: formData,
        success: function(response) {
          return eval(response);
        }
      });
    }
  });
});

window.resizeReading = function() {
  return $('.panel').each(function(i, p) {
    var image_height, title_line_height;
    image_height = $(p).find('img.source_cards_card_design').height();
    title_line_height = $(p).find('.title_line').height();
    if ($(p).hasClass('flip')) {
      return $(p).height($(p).find('.pane.back').outerHeight() + 30 + image_height + title_line_height);
    } else {
      if ($(p).hasClass('skip')) {
        return $(p).height($(p).find('.pane.fore').outerHeight() + 30);
      } else {
        return $(p).height($(p).find('.pane.front').outerHeight() + 30 + image_height);
      }
    }
  });
};

window.attachFlippers = function() {
  $('.card_reading_pane, .delivery_zone').off('click').on('click', '.flip_card', function(event) {
    if (!$(event.target).hasClass('subscribe')) {
      $(this).closest('.panel').toggleClass('flip');
      event.preventDefault();
    }
  });
  return $('.card_reading_pane, .delivery_zone').on('click', '.skip_card', function(event) {
    $(this).closest('.panel').toggleClass('skip');
    event.preventDefault();
  });
};

window.cinderellaFlip = function() {
  $('.panel.birth').removeClass('skip');
  $('.panel.birth').addClass('flip');
};