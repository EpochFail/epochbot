require 'json'

class Twitter < Rubot::WebResource
  def self.lasttweet(username)
    url = "http://api.twitter.com/1/statuses/user_timeline/" + username + ".json?count=1" 
    doc = open(url).read
    json = JSON.parse(doc)
    text = json
    text.first["text"]
  end
end
