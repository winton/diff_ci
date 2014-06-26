require "oj"
require "rack/parser"

Application.class_eval do
  
  use Rack::Parser, :content_types => {
    'application/json' => Proc.new { |body| Oj.load body }
  }
end