class WordnikController < Rubot::Controller

  command :define do
    reply Words.define(message.text)
  end
  
  command :example do
    reply Words.example(message.text)
  end
  
  command :related do
    reply Words.related(message.text)
  end
  
  command :phrases do
    reply Words.phrases(message.text)
  end
  
  command :wordsearch do
    reply Words.wordsearch(message.text)
  end
  
end