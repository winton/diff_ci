unless ENV['CI']
  require 'simplecov'
  SimpleCov.start
end

$root = File.expand_path('../../', __FILE__)
require "#{$root}/lib/diff_ci"