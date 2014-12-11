require 'open-uri'
require 'uri'

class Urban < Rubot::WebResource
  get :search, "http://www.urbandictionary.com/define.php" do |doc|
    doc.css('div.definition')[0].text
  end
end