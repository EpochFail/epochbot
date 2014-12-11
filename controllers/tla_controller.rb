class TlaController < Rubot::Controller
  command :tla do
    word = message.text.split.first    
    reply Tla.tla(word)
  end
  
  on :connect do
    Tla.init
  end
end