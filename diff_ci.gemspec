# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "diff_ci"
  spec.version       = "0.0.1"
  spec.authors       = ["Winton Welsh"]
  spec.email         = ["mail@wintoni.us"]
  spec.description   = %q{A service that checks the difference between an array across multiple sessions}
  spec.summary       = %q{A service that checks the difference between an array across multiple sessions.}
  spec.homepage      = "http://github.com/winton/diff_ci"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "bundler", "~> 1.3"
  spec.add_dependency "redis"
  spec.add_dependency "sinatra"

  spec.add_development_dependency "namer"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "simplecov"
end