# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec/rails/request_logger/version'

Gem::Specification.new do |spec|
  spec.name          = "rspec-rails-request_logger"
  spec.version       = Rspec::Rails::RequestLogger::VERSION
  spec.authors       = ["dm1try"]
  spec.email         = ["dmitry.dedov@tut.by"]
  spec.description   = %q{Logs test results for api requests}
  spec.summary       = %q{Logs test results for api requests}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rspec-rails", "~> 2.0"
  spec.add_dependency "coderay", "~> 1.0"
  spec.add_dependency "builder", "~> 3.0"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
