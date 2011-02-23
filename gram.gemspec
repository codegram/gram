# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "gram/version"

Gem::Specification.new do |s|
  s.name        = "gram"
  s.version     = Gram::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Josep M. Bach", "Josep Jaume Rey", "Oriol Gual"]
  s.email       = ["info@codegram.com"]
  s.homepage    = "http://github.com/codegram/gram"
  s.summary     = %q{Internal client for Codegram administration}
  s.description = %q{Internal client for Codegram administration}

  s.rubyforge_project = "gram"

  s.add_runtime_dependency 'rest-client'

  s.add_development_dependency 'bundler', '~> 1.0.7'
  s.add_development_dependency 'rspec',   '~> 2.5.0'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
