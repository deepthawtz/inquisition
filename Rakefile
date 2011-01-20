require 'rubygems'
require 'rake'
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

task :bootstrap do
  require "mongo"; include Mongo
  db = Connection.new("localhost", Connection::DEFAULT_PORT).db("puravida")
  db.drop_collection('vocab_quiz')
  Vocabulary = db.collection('vocab_quiz')

  vocab = YAML.load_file('bootstrap.yaml')
  puts "Loading vocab terms...\n"
  vocab.each do |term|
    puts "inserting: #{term[:english]} => #{term[:spanish]}"
    Vocabulary.insert({
      :english => term[:english],
      :spanish => term[:spanish],
      :type => term[:type],
      :points => term[:points]
    })
  end
end
