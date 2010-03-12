require "rubygems"
require "sinatra"
require "rack-flash"
require "haml"
require "mongo_mapper"

enable :sessions
use Rack::Flash
# logger = Logger.new("puravida.log")
# pass like Mongo::Connection.new("localhost", :port, :logger => logger)
MongoMapper.connection = Mongo::Connection.new("localhost")
MongoMapper.database = "purovida"

# fun little mapper model to MongoDB
class Vocabulary
  include MongoMapper::Document
  
  key :spanish, String, :required => true # validates_presence_of
  key :english, String, :required => true
  key :points, Integer, :default => 1
end

# was getting utf-8 errors regarding
# spanish letters [é, ñ, í]. @@@

#============================================
#               Buenos Días                  
#               McGraw Hill,                 
#          I want my $50 bucks back          
#============================================

get "/" do
  language = ["english", "spanish"].shuffle[0]
  vocab = Vocabulary.all.shuffle[0]

  # funky how django-like this part feels (ala render_to_response())
  haml :index, :locals => {
    :language => language,
    :word => vocab[language],
    :translation => translation(language),
  }
end

post "/" do
  language = params[:language]
  guess = params[:answer]
  
  # TODO: this is fail, gotta figure out why but for now...
  find_by_language = "find_by_#{language}".to_sym
  vocab_item = Vocabulary.send(find_by_language, guess)
  answer = vocab_item[translation(language)] || "bogus"
  
  if guess == answer
    flash[:notice] = "¡Correcto!"
    redirect("/")
  else
    redirect("/fail")
  end
end

get "/add" do
  # users can add more Spanish words for translation
  haml :add
end

post "/add" do
  # TODO: rescue this on fail
  vocab = Vocabulary.create({
    :english => params[:english],
    :spanish => params[:spanish],
    :points => params[:points]
  })
  vocab.save()

  redirect("/")
end

get "/fail" do
  # "fail" in the sense that you fail at Spanish vocab or spelling.
  haml :fail
end


helpers do

  def translation(language)
    (language == "english" ? "spanish" : "english")
  end

  # stuff

end
