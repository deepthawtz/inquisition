require 'rubygems'
require 'cucumber/rake/task'

task :default => [:cucumber]

Cucumber::Rake::Task.new do |t|
  t.libs << 'lib'
  t.cucumber_opts = "--format pretty"
#   t.rcov = true
#   t.rcov_opts << '--text-summary'
#   t.rcov_opts << '--sort' << 'coverage' << '--sort-reverse'
#   t.rcov_opts << '--exclude' << '.gem/,spec,features,examples'
end
