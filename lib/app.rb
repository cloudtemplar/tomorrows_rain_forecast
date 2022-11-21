# frozen_string_literal: true

require 'faraday'

API_URL = 'https://api.openweathermap.org'
API_KEY = ENV['OPENWEATHER_API_KEY']
GEOCODING_URL = '/geo/1.0/direct'
FORECAST_URL = '/data/2.5/forecast'
# You are getting forecast for 5 days with data every 3 hours, so returning 8 of them
# results in the last one being a timestamp in ~24 hours.
TIMESTAMPS_RETURNED = 8

conn = Faraday.new(
  url: API_URL,
  params: {
    appid: API_KEY
  }
)

geocoding_response = conn.get(GEOCODING_URL) do |req|
  req.params['q'] = ARGV[0]
end

city_coordinates = JSON.parse(geocoding_response.body).first
lat = city_coordinates['lat']
lon = city_coordinates['lon']

weather_response = conn.get(FORECAST_URL) do |req|
  req.params['cnt'] = TIMESTAMPS_RETURNED
  req.params['lat'] = lat
  req.params['lon'] = lon
end

main_weather = JSON.parse(weather_response.body)['list'].last['weather'].first['main']

forecast = if main_weather == 'Rain'
             "It will rain tomorrow in #{ARGV[0]}"
           else
             "It won't rain tomorrow in #{ARGV[0]}"
           end

puts forecast
