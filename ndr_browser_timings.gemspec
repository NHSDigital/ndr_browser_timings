# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'ndr_browser_timings/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'ndr_browser_timings'
  spec.version     = NdrBrowserTimings::VERSION
  spec.authors     = ['NDR Development Team']
  spec.summary     = 'Capture request timing data from clients'

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_dependency 'rails', '>= 5.2', '< 6.1'

  spec.add_development_dependency 'mocha'
  spec.add_development_dependency 'ndr_dev_support', '~> 5.5'
  spec.add_development_dependency 'ndr_stats' # support is included, but not required.
  spec.add_development_dependency 'sqlite3'
end
