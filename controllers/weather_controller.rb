class WeatherController < Rubot::Controller
  command :weather do
    if location = Weather.location(message.text)
      cur = location.fetch.current_conditions
      reply "#{location.name} - #{cur.description}, #{cur.temperature}F, Feels like: #{cur.feels_like}F, Wind: #{cur.wind.speed} #{cur.wind.direction}"
    else
      reply "location not found"
    end
  end
end