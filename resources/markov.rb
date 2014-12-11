class Markov
  class Word < Sequel::Model(:markov_words)
  end

  class Ender < Sequel::Model(:markov_enders)
  end

  def self.init
    @words = Word.all
    @enders = Ender.all
  end

  def self.persist
    DB.transaction do
      @words.select(&:modified?).each(&:save)
      @enders.select(&:modified?).each(&:save)
    end
  end

  def self.consume(sentence)
    words = sentence.split

    return if words.empty?

    words.each_cons(2) do |leader, follower|
      word = find_or_create_word(leader, follower)
      word.count += 1
    end

    ender = find_or_create_ender(words.last)
    ender.count += 1
  end

  def self.sentence(seed = nil)
    pool = seed ? @words.select { |w| w.leader == seed.to_s.downcase } : @words

    return nil if pool.empty?

    word = pool.sample

    sentence = [word.leader, word.follower]
    begin
      word = random_follower(word)
      sentence << word.follower if word
    end until end?(word)
    sentence.join(" ").strip
  end

  private

  def self.find_or_create_word(leader, follower)
    leader, follower = leader.downcase, follower.downcase
    word = @words.find { |w| w.leader == leader && w.follower == follower }
    unless word
      word = Word.new :leader => leader, :follower => follower, :count => 0
      @words << word
    end
    word
  end

  def self.find_or_create_ender(word)
    word = word.downcase
    ender = @enders.find { |e| e.word == word }
    unless ender
      ender = Ender.new :word => word, :count => 0
      @enders << ender
    end
    ender
  end

  def self.random_follower(word)
    random = rand(word.count) + 1
    partial_sum = 0
    @words.select { |w| w.leader == word.follower }.shuffle.find do |follower|
      partial_sum += follower.count
      partial_sum >= random
    end
  end

  def self.end?(word)
    return true unless word

    ender = @enders.find { |e| e.word == word.follower }
    end_count = ender ? ender.count : 0
    end_count *= 0.8
    (0...end_count).cover? rand(end_count + count_followers(word))
  end

  def self.count_followers(word)
    words = @words.select { |w| w.leader == word.follower }
    words.empty? ? 0 : words.map(&:count).inject(:+)
  end
end