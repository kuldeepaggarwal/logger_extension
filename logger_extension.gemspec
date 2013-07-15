# coding: utf-8
$:.push File.expand_path('../lib', __FILE__)
require 'logger_extension/version'

Gem::Specification.new do |spec|
  spec.name          = 'logger_extension'
  spec.version       = LoggerExtension::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.authors       = ['kuldeepaggarwal']
  spec.email         = ['kd.engineer@yahoo.co.in']
  spec.description   = 'A utility for logging on multiple files for rack applications'
  spec.summary       = 'A utility for logging on multiple files for rack applications.'
  spec.license       = "MIT"
  spec.files         = `git ls-files`.split("\n")
  spec.require_paths = ['lib']
  spec.homepage      = 'https://github.com/kuldeepaggarwal/logger_extension'
end