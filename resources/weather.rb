require "weather_man"

class Weather
  WeatherMan.partner_id = '1073366679'
  WeatherMan.license_key = '9335aec545f02a4d'

  def self.location(location_query)
    WeatherMan.search(location_query).first
  end
end