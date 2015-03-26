# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'speechmatics/version'

Gem::Specification.new do |spec|
  spec.name          = "speechmatics"
  spec.version       = Speechmatics::VERSION
  spec.authors       = ["Andrew Kuklewicz"]
  spec.email         = ["andrew@beginsinwonder.com"]
  spec.description   = %q{Ruby client for Speechmatics API: https://speechmatics.com/api-details}
  spec.summary       = %q{Ruby client for Speechmatics API: https://speechmatics.com/api-details}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency('faraday')
  spec.add_runtime_dependency('faraday_middleware')
  spec.add_runtime_dependency('multi_json')
  spec.add_runtime_dependency('excon')
  spec.add_runtime_dependency('hashie')
  spec.add_runtime_dependency('activesupport')
  spec.add_runtime_dependency('mimemagic')

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_development_dependency('minitest')
  spec.add_development_dependency('simplecov')
end
