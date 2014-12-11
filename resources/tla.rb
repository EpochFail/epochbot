class Tla
  def self.init
    @words = {}
    words = DictionaryWord.all
    words.each do |w|
      @words[w.word[0]] ||= []
      @words[w.word[0]] << w.word.downcase.strip
    end
  end
  
  def self.tla(word)
    word.each_char.map {|l| @words[l].sample }.join(" ")
  end
end
