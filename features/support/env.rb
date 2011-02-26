# A lot of this comes from the Cucumber wiki
# (http://wiki.github.com/aslakhellesoy/cucumber/sinatra)
app = File.join(File.dirname(__FILE__), *%w[.. .. app.rb])
require app
Sinatra::Application.app_file = app
set :environment, :test

require "rack/test"
require "capybara/cucumber"
Capybara.app = Sinatra::Application

class El_Mundo
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end
end

World { El_Mundo.new }


Before do
  db = Connection.new("localhost", Connection::DEFAULT_PORT).db("puravida")
  Vocabulary = db.collection("test_vocab_quiz")
  if defined? Vocabulary
    puts "------------------------------------------"
    puts "Using Mongo Collection: #{Vocabulary.name}"
    puts "------------------------------------------"
  end
  def Vocabulary.empty?
    (Vocabulary.count == 0 ? true : false)
  end
  def Vocabulary.all
    Vocabulary.find.to_a
  end
  # remove all records in collection
  Vocabulary.remove
end
