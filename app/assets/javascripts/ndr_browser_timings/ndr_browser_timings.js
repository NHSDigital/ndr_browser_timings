window.addEventListener('load', function() {
  // Defer the timing collection in order to allow the onLoad event to finish first.
  setTimeout(sendPerformanceTimingData, 0);

  // Periodically, send timing for AJAX requests:
  setInterval(sendNewPerformanceResourceTimingData, 1000);
});

function sendPerformanceTimingData() {
  sendTimingData({
    'pathname': window.location.pathname,
    'performance_timing': window.performance.timing
  });
};

var oldEntries = [];
var endpoint = '/browser_timings'

function sendNewPerformanceResourceTimingData() {
  var newEntries = window.performance.getEntries()
                   .filter(function(entry) { return !~oldEntries.indexOf(entry) })
                   .filter(function(entry) { return !~entry.name.indexOf(endpoint) });

  newEntries.forEach(function(resourceTiming) { oldEntries.push(resourceTiming) });

  if (newEntries.length) sendTimingData({ 'resource_timings': newEntries });
};

function sendTimingData(data) {
  var request = new XMLHttpRequest(),
      token = document.querySelector('meta[name="csrf-token"]').content;

  data.user_agent = navigator.userAgent;

  request.open('POST', endpoint);
  request.setRequestHeader('X-CSRF-Token', token);
  request.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');
  request.send(JSON.stringify(data));
};
