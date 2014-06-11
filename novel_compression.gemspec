# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'novel_compression/version'

Gem::Specification.new do |spec|
  spec.name          = "novel_compression"
  spec.version       = NovelCompression::VERSION
  spec.authors       = ["Nikolai Colton"]
  spec.email         = ["ncolton@oddmagic.net"]
  spec.description   = 'Implementation of a solution for programming challenge creating a text compression program.'
  spec.summary       = 'Text Compressor'
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-bundler'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'terminal-notifier-guard'
  spec.add_development_dependency 'rspec', '~>2'
end
