# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "geolocator/version"

Gem::Specification.new do |s|
  s.name        = "geolocator"
  s.license     = 'MIT'
  s.version     = Geolocator::VERSION
  s.authors     = ["Dan Barrett"]
  s.email       = ["dbarrett83@gmail.com"]
  s.homepage    = "http://www.about.me/thoughtpunch"
  s.summary     = "Yet Another IP Geolocation Gem"
  s.description = "geolocator is a simple ruby wrapper for the freegeoip.net API"

  s.rubyforge_project = "geolocator"
  
  s.required_ruby_version = '>= 1.9.0'
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_development_dependency "guard"
  s.add_dependency "faraday"
  s.add_dependency "json"
end
