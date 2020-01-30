(function() {
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
        .filter(function (entry) { return !~this.recordedEntries.indexOf(JSON.stringify(entry)) }.bind(this))
        .filter(function (entry) { return !~entry.name.indexOf(this.endpoint) }.bind(this))

      if (newEntries.length) {
        this.sendTimingData({ resource_timings: newEntries })

        // IE11 can't compare the timing objects directly; compare stringified versions instead...
        newEntries = newEntries.map(function(entry) { return JSON.stringify(entry) })
        this.recordedEntries = this.recordedEntries.concat(newEntries)
      }
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
}).call(this)
