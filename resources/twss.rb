class Twss
  class Keyword < Sequel::Model(:twss_keywords)
  end
  
  class Listener < Sequel::Model(:twss_listener)
  end
  
  class Exclude < Sequel::Model(:twss_exclude)
  end
  
  @@lastMessage
  
  def self.lastMessage
    @@lastMessage
  end
  
  def self.saveMessage(sentence)
    @@lastMessage = sentence
  end
	    
  def self.init
    @keywords = Keyword.all
	  @listener = Listener.all
	  @excludes = Exclude.all
  end
  
  def self.persist
    DB.transaction do
	    @listener.select(&:modified?).each(&:save)
	    @keywords.select(&:modified?).each(&:save)
	    @excludes.select(&:modified?).each(&:save)
	  end
  end
  
  def self.consume
    words = lastMessage.split
	
	  words.each do |word|
	    word.downcase
	    exclude = @excludes.find { |e| e.word == word }
	    keyword = @keywords.find { |w| w.word == word }
	    unless exclude || keyword
	      listener = find_or_create_listener(word)
	      listener.count += 1
	  	  saveKeyword(listener.word) if listener.count >= 5
	    end
	  end
  end
  
  def self.saveKeyword(word)
	  word = word.downcase
	  exclude = @excludes.find { |e| e.word == word }
	  unless exclude
	    keyword = @keywords.find { |w| w.word == word }
	    unless keyword
	      keyword = Keyword.new :word => word
	      @keywords << keyword
        return "Keyword " + word + " added"
	    end
	    delete_listener(word)
      return "Keyword " + word + " already exists"
	  end  
	  return "Keyword " + word + " could not be added, it is on the exclude list."
  end
  
  def self.excludeKeyword(word)
	  word = word.downcase
	  exclude = @excludes.find { |e| e.word == word }
	  unless exclude
	    exclude = Exclude.new :word => word
	    @excludes << exclude
	  end
	  delete_keyword(word)
	  delete_listener(word)
	  word
  end
	
  def self.trigger(sentence)
	  return true if @keywords.any? { |w| sentence =~ /\b#{w[:word]}\b/i }
	  return false
  end
  
  private
  
  def self.find_or_create_listener(word)
	  listener = @listener.find { |l| l.word == word }
	  unless listener
	    listener = Listener.new :word => word, :count => 0
	    @listener << listener
	  end
	  listener
  end
  
  def self.delete_keyword(word)
    keyword = @keywords.find { |w| w.word == word }
	  if keyword != nil
	    keyword.destroy if keyword.modified?
	    @keywords.delete(keyword)
	  end
  end
  
  def self.delete_listener(word)
    listener = @listener.find { |l| l.word == word }
	  if listener != nil
	    listener.destroy
	    @listener.delete(listener)
	  end
  end
end