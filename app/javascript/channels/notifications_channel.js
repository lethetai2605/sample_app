import consumer from "./consumer"

consumer.subscriptions.create("NotificationsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    var $counter, val;
    $counter = $(`#notification-counter-${data.poster}`);
    val = parseInt($counter.text());
    if (data.destroy == true) {
      $(`#notification-${data.micropost.id}`).html("");
      val -= 1;
    } else {
      $(`#notification-menu-${data.poster}`).prepend("" + data.notification);
      val += 1;
    }
    return $counter.text(val)
  }
});
