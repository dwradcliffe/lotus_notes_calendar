require 'rubygems'
require 'bundler'

require 'simplecov'
SimpleCov.start do
  add_filter '/vendor/bundle/'
  add_filter '/test/'
end

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts 'Run `bundle install` to install missing gems'
  exit e.status_code
end
require 'test/unit'
require 'shoulda'
require 'turn'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'lotus_notes_calendar'

class Test::Unit::TestCase
end
