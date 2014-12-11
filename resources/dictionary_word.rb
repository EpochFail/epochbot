class DictionaryWord < Sequel::Model
  def self.random
    DB["select * from dictionary_words order by random() limit 1"].first[:word]
  end
end