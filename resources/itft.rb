class ITFT < Rubot::WebResource
  get :itft, "http://itsthisforthat.com/api.php?json" do |doc|
    json = JSON.parse(doc.text)
    "It's like " + json['this'] + " for " + json['that']
  end
end
