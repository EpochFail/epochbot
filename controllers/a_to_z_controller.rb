class AToZController < BaseController
  channel_variables :word, :first, :last

  command :az do
    if end?
      reply "Game ended. Answer was #{word}"
      end_game
    elsif alphabet?
      reply [*'a'..'z'].join(" ")
    elsif playing?
      print_range
    else
      start_game
      print_range
    end
  end

  listener :matches => /^\w+$/i do
    guess = message.text.downcase
    if correct? guess
      if message.pm? # PM, no points awarded
        reply "you win!"
      else
        reply "#{message.from} wins! +10 points"
        PointTransaction.create({
          :amount => 10,
          :receiver => current_user,
          :reason => "Won !az",
          :generated => true
        })
      end

      end_game
    elsif update guess
      print_range
    end
  end

  def print_range
    reply "#{range} (#{range_size})"
  end

  def end?
    message.text =~ /--end/i
  end

  def alphabet?
    message.text =~ /--alphabet/i
  end

  def start_game
    self.word = DictionaryWord.random.downcase
    self.first = DictionaryWord.order(:word).first.word
    self.last = DictionaryWord.order(:word).last.word
  end

  def playing?
    !!word
  end

  def correct?(guess)
    word == guess
  end

  def range
    first..last
  end

  def range_size
    DB["select count(1) - 2 count from dictionary_words where word between ? and ?", first, last].first[:count]
  end

  def end_game
    reply Words.define(word)
  ensure
    self.word = self.first = self.last = nil
  end

  def update(guess)
    # if guess is not in range, don't bother
    return unless range.cover?(guess)

    # make sure word is 'valid' before updating the range
    return unless DictionaryWord.first(:word => guess)
    
    # don't count guesses that touch the outer edges
    # there could totally be a problem here if the answer is ever randomly chosen to be the first or last word in the dict :)
    return if first == guess or last == guess
    
    if guess < word
      self.first = guess
    else
      self.last = guess
    end
  end
end
