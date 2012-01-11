# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "geolocater/version"

Gem::Specification.new do |s|
  s.name        = "geolocater"
  s.version     = Geolocater::VERSION
  s.authors     = ["Daniel Barrett"]
  s.email       = ["dbarrett83@gmail.com"]
  s.homepage    = "http://www.about.me/thoughtpunch"
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "geolocater"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_development_dependency "guard"
  s.add_development_dependency "vcr"
  s.add_development_dependency "faraday"
end
