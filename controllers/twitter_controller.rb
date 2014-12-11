class TwitterController < Rubot::Controller
  command :twitter do
    reply Twitter.lasttweet(message.text)
  end
end
