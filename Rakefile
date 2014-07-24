require 'rake/testtask'

task :default => :test

Rake::TestTask.new do |t|
  t.pattern = "test/**/*_test.rb"
end

Rake::TestTask.new("test:functional") do |t|
  t.pattern = "test/functional/*_test.rb"
end