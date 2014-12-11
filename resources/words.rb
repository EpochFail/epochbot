require 'wordnik'

class Words
  
  #this probably needs to move at some point
  Wordnik.configure do |config|
      config.api_key = 'fca7c0d383b87a4a5d10700e034075cccc70c15113714972c'
      config.response_format = :json
  end
  
  def self.define(search)    
    Wordnik.word.get_definitions(search, :limit => 1)[0]["text"] || "No Results Found"
  end
  
  def self.example(search)
    Wordnik.word.get_top_example(search)["text"]
  end
  
  def self.related(search)
    Wordnik.word.get_related_words(search)[0]["words"].join(", ")
  end
  
  def self.phrases(search)
    query = Wordnik.word.get_phrases(search)
    phrases = []
    query.each{|x|phrases << x["gram1"] + " " + x["gram2"] }
    phrases.join(", ")
  end
  
  def self.wordsearch(search)
    query = Wordnik.words.search_words_new(search)
    results = []
    query["searchResults"].each{|x| results << x["word"]}
    results.join(", ")
  end
  
end