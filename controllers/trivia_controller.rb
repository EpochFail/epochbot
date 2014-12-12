require "text"

class TriviaController < BaseController
  channel_variable :data

  command :trivia do
    if message.text =~ /--end/i
      reply "Game ended. Answer was #{answer}"
      self.data = nil
    end
    
    start_game
  end

  listener do
    next unless data
    guess = message.text.downcase.strip

    if correct? guess
      if message.pm? # PM, no points awarded
        reply "you win!"
      else
        reply "#{message.from} won Trivia! +1 points. Answer: #{answer}"
        PointTransaction.create :amount => 1, :receiver => current_user, :reason => "won trivia", :generated => true
      end

      self.data = nil
      start_game
    end
  end

  def start_game
    unless data
      self.data = Trivia.random
      data[:normalized_answer] = normalize(answer)
    end
    reply question
  rescue StandardError => e
    reply "error , try again: #{e.message}"
  end

  def correct?(guess)
    # if answer is nothing but digits, do a straight comparision.
    # otherwise delegate to Levenshtein
    if normalized_answer =~ /^[.\d]+$/
      normalized_answer == normalize(guess)
    else
      Text::Levenshtein.distance(normalized_answer, normalize(guess)) < 3
    end
  end

  def question
    data[:question]
  end

  def answer
    data[:answer]
  end

  def normalized_answer
    data[:normalized_answer]
  end

  def normalize(str)
    str.downcase.gsub(/\s/, '')
  end
end
