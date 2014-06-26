require "rubygems"
require "bundler"

Bundler.setup(:default)

$:.unshift File.dirname(__FILE__)

require 'diff_ci/application'

require 'application/sinatra'
require 'application/log'
require 'application/rack_parser'
require 'application/redis'
require 'application/controller'