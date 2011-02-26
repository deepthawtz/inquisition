# encoding: UTF-8
%w[ rubygems sinatra haml ./setup ].map {|x| require x }

set :vocab, Vocabulary.all.shuffle()
set :environment, :development
set :sessions, true

before do
  content_type :html, "charset" => "utf-8"
end

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
  if ghetto_validator(params)
    Vocabulary.insert({
      :english => params[:english],
      :spanish => params[:spanish],
      :type => params[:type],
      :points => params[:points]
    })
    redirect "/"
  else
    redirect "/add"
  end
end

get "/fail" do
  haml :fail
end

get "/help" do
  haml :help
end

get "/preferences" do
  haml :prefs
end

get "/reset" do
  set :vocab, Vocabulary.all.shuffle()
  redirect "/"
end

get "/stats" do
  haml :stats, :locals => {:vocab => Vocabulary.all}
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
      :type => vocab[:type],
      :translate_for => flip(language_of_word),
    }.merge! extra
  end

  def ghetto_validator(vocab)
    if (vocab[:english].empty? && vocab[:spanish].empty?)
      false
    else
      # valid = {
      #   :english => /\w*/,
      #   :spanish => /\w*/,
      #   :type => /noun|verb|adjective/,
      #   :points => /1|2|3|4|5|6|7|8|9|10/
      # }
      # valid.each do |k,regex|
      #   if not vocab[k].grep(valid[k])
      #     return false
      #   end
      # end
      true
    end
  end
end

