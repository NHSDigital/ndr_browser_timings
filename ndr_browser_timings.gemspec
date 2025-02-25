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
  gem_files        = %w[CHANGELOG.md CODE_OF_CONDUCT.md LICENSE.txt README.md Rakefile
                        app config db lib]
  spec.files       = `git ls-files -z`.split("\x0").
                     select { |f| gem_files.include?(f.split('/')[0]) }

  spec.add_dependency 'rails', '>= 7.0', '< 8.1'

  spec.required_ruby_version = '>= 3.1.0'

  spec.add_development_dependency 'mocha'
  spec.add_development_dependency 'ndr_dev_support', '>= 6.0'
  spec.add_development_dependency 'ndr_stats' # support is included, but not required.
  spec.add_development_dependency 'puma'
  spec.add_development_dependency 'sprockets-rails', '>= 3.0.0'

  # Rails 7.0 does not support sqlite3 2.x; it specifies gem "sqlite3", "~> 1.4"
  # in lib/active_record/connection_adapters/sqlite3_adapter.rb
  # cf. gemfiles/Gemfile.rails70
  spec.add_development_dependency 'sqlite3'
end
