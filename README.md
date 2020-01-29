# NdrBrowserTimings
This Rails Engine adds JavaScript that allows for the collection of users' browser timing information.

## Usage
Once installed (see below), timing information will be submitted from browsers
via AJAX, back to the mounted engine, and passed to any configured recorders.

Recorders can be any callable object, and can be configured like so:

```ruby
NdrBrowserTimings.recorders << ->(timing) { MyService.notify(timing) }
```

This gem bundles some recorders:

```ruby
# Send info to the Rails log:
require 'ndr_browser_timings/recorders/logger'
NdrBrowserTimings.recorders << NdrBrowserTimings::Recorders::Logger.new

# Send info to prometheus:
require 'ndr_browser_timings/recorders/ndr_stats'
NdrStats.configure(...)
NdrBrowserTimings.recorders << NdrBrowserTimings::Recorders::NdrStats.new
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'ndr_browser_timings'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install ndr_browser_timings
```

Inject the client library into pages you want timings submitted from:

```javascript
//=require 'ndr_browser_timings/ndr_browser_timings'
```

and the `<meta>` tag to provide configuration to the client library:

```ruby
<%= ndr_browser_timings_meta_tag %>
```

This is an isolated engine, so you'll need to configure with an authentication check:

```ruby
# Allow all requests through (careful!):
NdrBrowserTimings.check_current_user_authentication = ->(request) { true }
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## TODO:
* javascript fallback
