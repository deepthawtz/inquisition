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

  db = Connection.new("localhost", Connection::DEFAULT_PORT).db("puravida")
  TestVocabulary = db.collection("test_vocab_quiz")
  if defined? TestVocabulary
    puts "------------------------------------------"
    puts "Using Mongo Collection: #{TestVocabulary.name}"
    puts "------------------------------------------"
  end

  def TestVocabulary.empty?
    (TestVocabulary.count == 0 ? true : false)
  end

  def TestVocabulary.all
    TestVocabulary.find.to_a
  end
end

World { El_Mundo.new }
