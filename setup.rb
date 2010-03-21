
require "mongo"; include Mongo

db = Connection.new("localhost", Connection::DEFAULT_PORT).db("puravida")
Vocabulary = db.collection('vocab_quiz')


# um, ghetto. but makes sense right?
def Vocabulary.all
  Vocabulary.find.to_a
end
