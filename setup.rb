begin
  require "mongo"; include Mongo
rescue LoadError
  puts "You need the mongo gem\nTry: gem install mongo"
  exit(1)
end

begin
  db = Connection.new("localhost", Connection::DEFAULT_PORT).db("puravida")
  Vocabulary = db.collection("vocab_quiz")
rescue Mongo::ConnectionFailure
  puts "Make sure MongoDB daemon (mongod) is running\nTry: mongod"
  exit(1)
end


def Vocabulary.all
  Vocabulary.find.to_a
end

def Vocabulary.empty?
  (Vocabulary.count == 0 ? true : false)
end
