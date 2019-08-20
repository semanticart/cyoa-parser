require 'rake/testtask'
require 'bundler'
Bundler.require

task :default => [:test]

Rake::TestTask.new do |t|
  t.pattern = "spec/*_spec.rb"
end
