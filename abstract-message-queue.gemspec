# -*- encoding: utf-8 -*-
require File.expand_path("lib/abstract_message_queue/version", File.dirname(__FILE__))

Gem::Specification.new do |s|
  s.name        = "abstract-message-queue"
  s.version     = AMQ::Version::STRING
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["William Howard"]
  s.email       = ["whoward.tke@gmail.com"]
  s.summary     = "Leadformance gem to abstract multiple message queue backends and provide data encoding/decoding"

  s.files         = Dir.glob("lib/**/*.rb")
  s.test_files    = Dir.glob("spec/**/*.rb")
  s.require_paths = ["lib"]

  s.add_dependency "json", "~> 1.6"
  s.add_dependency "active_support", "~> 3.0"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec", "~> 2.6"
  s.add_development_dependency "stomp", "~> 1.1"
  s.add_development_dependency "aws-sdk", "~> 1.0"
end
