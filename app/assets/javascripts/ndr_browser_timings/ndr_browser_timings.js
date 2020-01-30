function NdrBrowserTimings () {
  this.bindListeners = function () {
    window.addEventListener('load', function () {
      // Defer the timing collection in order to allow the onLoad event to finish first.
      setTimeout(this.sendPerformanceTimingData, 0)

      // Periodically, send timing for AJAX requests:
      setInterval(this.sendNewPerformanceResourceTimingData, 1000)
    }.bind(this))
  }

  this.sendPerformanceTimingData = function () {
    this.sendTimingData({
      'pathname': window.location.pathname,
      'performance_timing': window.performance.timing
    })
  }

  this.sendNewPerformanceResourceTimingData = function () {
    var newEntries = window.performance.getEntriesByType('resource')
      .filter((entry) => { return !~this.recordedEntries.indexOf(entry) })
      .filter((entry) => { return !~entry.name.indexOf(this.endpoint) })

    newEntries.forEach((resourceTiming) => { this.recordedEntries.push(resourceTiming) })

    if (newEntries.length) this.sendTimingData({ resource_timings: newEntries })
  }

  this.sendTimingData = function (data) {
    var request = new XMLHttpRequest()
    var token = this.readMetaTag('csrf-token')

    data.user_agent = navigator.userAgent

    request.open('POST', this.endpoint)
    if (token) request.setRequestHeader('X-CSRF-Token', token)
    request.setRequestHeader('Content-Type', 'application/json;charset=UTF-8')
    request.send(JSON.stringify(data))
  }

  this.readMetaTag = function (name) {
    var metaTag = document.querySelector('meta[name="' + name + '"]')
    return metaTag && metaTag.content
  }

  // resource timings that have been sent:
  this.recordedEntries = []

  // Path to which data is sent:
  this.endpoint = this.readMetaTag('ndr_broser_timings_endpoint')
  if (this.endpoint) this.bindListeners()
}

NdrBrowserTimings()
