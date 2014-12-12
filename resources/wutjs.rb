class Wutjs < Rubot::WebResource
  get :wut, "http://word.ralreegorganon.com/api/word" do |doc|
    json = JSON.parse(doc.text)
    json['word']+".js"
  end
end
