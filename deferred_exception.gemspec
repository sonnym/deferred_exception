# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'deferred_exception/version'

Gem::Specification.new do |spec|
  spec.name          = 'deferred_exception'
  spec.version       = DeferredException::VERSION
  spec.authors       = ['sonnym']
  spec.email         = ['michaud.sonny@gmail.com']
  spec.description   = 'Collect exceptions rather than exiting early when enumerating atomic operations.'
  spec.summary       = spec.description
  spec.homepage      = 'https://github.com/sonnym/deferred_exception'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pry'
end
