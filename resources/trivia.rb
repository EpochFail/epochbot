class Trivia < Rubot::WebResource
  get :random, 'http://www.gamesforthebrain.com/game/trivia/' do |doc|
    question = doc.css("p.question span").first.text.strip
    answer = doc.search("input[name='answer']").first.attributes["value"].text.strip
    { :question => question, :answer => answer }
  end
end