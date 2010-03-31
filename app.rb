%w[ rubygems sinatra haml setup ].map {|x| require x }
$KCODE='utf-8'

set :vocab, Vocabulary.all.shuffle()
set :environment, :development
set :sessions, true


get "/" do
  language_of_word = [:english, :spanish].shuffle[0]
  
  if vocab = settings.vocab.shift
    haml :quiz, :locals => {
      :language => language_of_word,
      :word => vocab[language_of_word.to_s],
      :translate_for => flip(language_of_word),
    }
  elsif Vocabulary.empty?
    haml :start
  else
    haml :done
  end
end

post "/" do
  word = params[:word]
  guess = params[:answer]
  language_of_guess = params[:language]
  
  if translation_correct?(word, guess, language_of_guess)
    redirect "/"
  else
    redirect "/fail"
  end
end

get "/add" do
  haml :add
end

post "/add" do
  Vocabulary.insert({
    :english => params[:english],
    :spanish => params[:spanish],
    :points => params[:points]
  })
  redirect "/"
end

get "/fail" do
  haml :fail
end

get "/reset" do
  set :vocab, Vocabulary.all.shuffle()
  redirect "/"
end


helpers do
  def flip(language)
    (language == :english ? "spanish" : "english")
  end
  
  def translation_correct?(o, t, l)
    a = Vocabulary.find({l => o}).to_a[0]
    if a[flip(l.to_sym)] == t
      true
    else
      false
    end
  end
end

