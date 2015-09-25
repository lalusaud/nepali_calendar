$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "nepali_calendar/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "nepali_calendar"
  s.version     = NepaliCalendar::VERSION
  s.authors     = ["Lal B. Saud"]
  s.email       = ["lalusaud@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of NepaliCalendar."
  s.description = "TODO: Description of NepaliCalendar."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.4"

  s.add_development_dependency "sqlite3"
end
