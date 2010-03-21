# Setup for Sinatra with Cucumber
# (http://wiki.github.com/aslakhellesoy/cucumber/sinatra)
app = File.join(File.dirname(__FILE__), *%w[.. .. app.rb])
require app
Sinatra::Application.app_file = app


require "spec"
require "rack/test"
require "webrat"

Webrat.configure do |config|
  config.mode = :rack
end

class El_Mundo
  include Rack::Test::Methods
  include Webrat::Methods
  include Webrat::Matchers
  
  Webrat::Methods.delegate_to_session :response_code, :response_body
  
  def app
    Sinatra::Application
  end
end

World { El_Mundo }