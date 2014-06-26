require "oj"
require "rack/parser"

Application.class_eval do
  
  use Rack::Parser, :parsers => {
    'application/json' => proc { |body| Oj.load body }
  }
end