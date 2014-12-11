class MarkovController < Rubot::Controller
  command :markov do
    #sentence = Markov.sentence(message.text.split.first)
    #reply sentence if sentence
    reply "markov is disabled"
  end

  #listener do
  #  Markov.consume message.text
  #end

  #on :connect do
  #  Markov.init

  #  Scheduler.every "30m" do
  #    Markov.persist
  #  end
  #end

  #on :quit do
  #  Markov.persist
  #end
end
