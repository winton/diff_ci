unless ENV['CI']
  require 'simplecov'
  SimpleCov.start
end

ENV['RACK_ENV'] = 'test'

require 'rack/test'

$root = File.expand_path('../../', __FILE__)
require "#{$root}/lib/diff_ci"