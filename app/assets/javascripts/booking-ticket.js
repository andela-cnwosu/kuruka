$(function() {
  var currentTime = moment().unix(); // Example (Timestamp) - Mon, 12 Sep 2016 13:00:00 GMT
  var eventTime = moment($('.countdown').data('countdown')).unix();
  var diffTime = (eventTime - currentTime);
  var duration = moment.duration(diffTime * 1000, 'milliseconds');
  var interval = 1000;

    setInterval(function() {
      duration = moment.duration(duration - interval, 'milliseconds');
      var text = '';
      if (duration.days() > 0) {
        var text = text + duration.days() + ' days ';
      } else if (duration.days() == 1) {
        var text = text + '1 day';
      }
      text = text + duration.hours() + ":" + duration.minutes() + ":" + duration.seconds();
      $('.countdown').text(text);
    }, interval);
});