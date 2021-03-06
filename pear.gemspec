# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pear/version'

Gem::Specification.new do |spec|
  spec.name          = "pear"
  spec.version       = Pear::VERSION
  spec.authors       = ["Horacio Bertorello"]
  spec.email         = ["syrii@msn.com"]
  spec.summary       = %q{Pear is a pair-programming command-line tool for Git.}
  spec.homepage      = "https://github.com/svankmajer/pear"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.3"
  spec.add_development_dependency "rspec", "~> 3.0"
end
