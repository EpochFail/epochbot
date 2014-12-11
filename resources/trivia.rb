class Trivia < Rubot::WebResource
  get :random, 'http://trivia.ralreegorganon.com/api/trivia/random' do |doc|
    json = JSON.parse(doc.text)
    question = json['question']
    answer = json['answer']
    { :question => question, :answer => answer }
  end
end
