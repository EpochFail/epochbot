class Wutjs < Rubot::WebResource
  get :wut, "http://wutjs.com/api/word" do |doc|
    json = JSON.parse(doc.text)
    json['Word']+".js"
  end
end
