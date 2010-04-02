%w[ rubygems sinatra haml setup ].map {|x| require x }
$KCODE="utf-8"

set :vocab, Vocabulary.all.shuffle()
set :environment, :development
set :sessions, true


get "/" do
  if vocab = settings.vocab.shift
    haml :quiz, :locals => prep_quiz_question(vocab)
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
    if vocab = settings.vocab.shift
      haml :quiz, :locals => prep_quiz_question(vocab, :message => "¡correcto!")
    else
      haml :done
    end
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
    (language.to_sym == :english ? "spanish" : "english")
  end
  
  def translation_correct?(o, t, l)
    if Vocabulary.find_one({l => o, flip(l) => t})
      true
    else
      false
    end
  end
  
  def prep_quiz_question(vocab, extra={})
    language_of_word = [:english, :spanish].shuffle[0].to_s
    {
      :language => language_of_word,
      :word => vocab[language_of_word],
      :translate_for => flip(language_of_word),
    }.merge! extra
  end
end

