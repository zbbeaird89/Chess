gem "rspec"
require "rspec/core/rake_task"

task :default => :spec

RSpec::Core::RakeTask.new(:spec) do |task|
	task.rspec_opts = ["-f documentation"]
	task.verbose = false
end