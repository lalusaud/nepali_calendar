# frozen_string_literal: true

$:.push File.expand_path("../lib", __FILE__)
# Maintain your gem's version:
require 'nepali_calendar/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name                   = 'nepali_calendar'
  spec.version                = NepaliCalendar::VERSION
  spec.authors                = ['Lal B. Saud']
  spec.email                  = ['lalusaud@gmail.com']
  spec.summary                = 'Get dates for BS & AD Calendars'
  spec.description            = 'Generate Nepali Calendar (Bikram Sambat) and convert dates between BS & AD.'
  spec.homepage               = 'https://github.com/lalusaud/nepali_calendar'
  spec.license                = 'MIT'

  spec.files                  = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir                 = 'exe'
  spec.executables            = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths          = ['lib']

  spec.required_ruby_version  = '>= 2.4.0'
  spec.add_dependency 'rails', '~> 6.1.0'

  spec.add_development_dependency 'bundler', '~> 2.0.2'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.8.0'
  spec.add_development_dependency 'sqlite3'
end
