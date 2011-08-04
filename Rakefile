require File.expand_path("lib/abstract_message_queue/version", File.dirname(__FILE__))
require 'rspec/core/rake_task'

GEM_PREFIX = "abstract-message-queue"

namespace :build do
  desc "builds the gem"
  task :gem do
    `gem build #{GEM_PREFIX}.gemspec`
  end

  desc "builds and installs the gem into your local rubygems"
  task :install => [:gem] do
    `gem install #{GEM_PREFIX}-#{AMQ::Version::STRING}.gem`

    Rake::Task["build:clean"].invoke
  end

  task :clean do
    system "rm #{GEM_PREFIX}-#{AMQ::Version::STRING}.gem"
  end
end

RSpec::Core::RakeTask.new do |t|
  t.pattern = FileList["spec/**/*_spec.rb"]
end