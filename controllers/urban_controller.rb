class UrbanController < Rubot::Controller
  
  command :urban do
    reply Urban.search(:term => message.text)
  end
end