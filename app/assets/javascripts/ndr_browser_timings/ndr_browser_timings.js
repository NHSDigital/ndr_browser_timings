class NdrBrowserTimings {
  constructor(endpoint) {
    // Path to which data is sent:
    this.endpoint = endpoint

    // resource timings that have been sent:
    this.recordedEntries = []

    this.bindListeners()
  }

  bindListeners() {
    window.addEventListener('load', () => {
      // Defer the timing collection in order to allow the onLoad event to finish first.
      setTimeout(() => { this.sendPerformanceTimingData() }, 0);

      // Periodically, send timing for AJAX requests:
      setInterval(() => { this.sendNewPerformanceResourceTimingData() }, 1000);
    });
  }

  sendPerformanceTimingData() {
    this.sendTimingData({
      'pathname': window.location.pathname,
      'performance_timing': window.performance.timing
    });
  }

  sendNewPerformanceResourceTimingData() {
    var newEntries = window.performance.getEntries()
                     .filter((entry) => { return !~this.recordedEntries.indexOf(entry) })
                     .filter((entry) => { return !~entry.name.indexOf(this.endpoint) });

    newEntries.forEach((resourceTiming) => { this.recordedEntries.push(resourceTiming) });

    if (newEntries.length) this.sendTimingData({ 'resource_timings': newEntries });
  }

  sendTimingData(data) {
    var request = new XMLHttpRequest(),
        token = document.querySelector('meta[name="csrf-token"]').content;

    data.user_agent = navigator.userAgent;

    request.open('POST', this.endpoint);
    request.setRequestHeader('X-CSRF-Token', token);
    request.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');
    request.send(JSON.stringify(data));
  }
}

new NdrBrowserTimings('/browser_timings');
