$(document).on('turbo:load', function() {
  window.addEventListener('message', function (event) {
    if (event.origin != 'https://www.lifeelevated.life') {
      return;
    }
    if (event.data == 'CS') {
      if (member_is_logged_in()) {
        window.parent.postMessage(window.logged_in_member_email, 'http://players.lifeelevated.life');
      } else {
        window.parent.postMessage('NO', 'http://players.lifeelevated.life');
      }
    } else {
      window.parent.postMessage('IR', 'http://players.lifeelevated.life'); // Invalid request
    }
  });
});

window.logged_in_member = false;
window.logged_in_member_email = '';

function member_is_logged_in() {
  return window.logged_in_member;
}
