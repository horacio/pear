require "bundler/gem_tasks"

task :default => [:spec]

begin
  require 'rspec/core/rake_task'
  desc "Run the specs"
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
  puts "Unfortunately, it seems that RSpec is unavailable."
end
