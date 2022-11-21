# frozen_string_literal: true

require_relative 'lib/tomorrows_rain_forecast_service'

API_KEY = ENV['OPENWEATHER_API_KEY']

if API_KEY.nil?
  puts 'Please provide the OpenWeatherMap API Key as an envar'
  puts "$ export OPENWEATHER_API_KEY='<OpenWeatherMap API KEY>'"

  return
end

city = ARGV[0]

if city.nil?
  puts 'Please specify a city to learn whether it is going to rain there tomorrow.'
  puts "Usage: '$ ruby tomorrows_rain_forecast.rb <CITY NAME>'"

  return
end

forecast = TomorrowsRainForecastService.new.call(city:)

puts forecast
