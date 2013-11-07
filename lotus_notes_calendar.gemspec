# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lotus_notes_calendar/version'

Gem::Specification.new do |spec|
  spec.name          = "lotus_notes_calendar"
  spec.version       = LotusNotesCalendar::VERSION
  spec.authors       = ["David Radcliffe"]
  spec.email         = ["radcliffe.david@gmail.com"]
  spec.description   = %q{Given a Lutus Notes calendar url, parse events into ruby class. Includes basic query options.}
  spec.summary       = %q{Library to fetch and parse events from a Lotus Notes calendar.}
  spec.homepage      = "https://github.com/dwradcliffe/lotus_notes_calendar"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'nokogiri', '~> 1.5.5'

  spec.add_development_dependency 'bundler',   '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'shoulda',   '~> 3.5.0'
  spec.add_development_dependency 'simplecov', '~> 0.7.1'
  spec.add_development_dependency 'turn',      '~> 0.9.6'
  spec.add_development_dependency 'minitest',  '~> 3.4.0'
end
