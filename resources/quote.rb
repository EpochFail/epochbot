class Quote < Rubot::WebResource
  get :chuck, "http://4q.cc/index.php?pid=fact&person=chuck" do |doc|
    doc.css("#factbox")[0].text.strip
  end
end