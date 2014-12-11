class QuoteController < Rubot::Controller
  command :chuck do
    reply Quote.chuck
  end
end