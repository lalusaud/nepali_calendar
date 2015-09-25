# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nepali_calendar/version'

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
  spec.required_ruby_version  = '>= 1.9.3'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.2'
end
