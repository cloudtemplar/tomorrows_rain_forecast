# frozen_string_literal: true

require_relative 'lib/tomorrows_rain_forecast_service'

city = ARGV[0]

if city.nil?
  puts 'Please specify a city to learn whether it is going to rain there tomorrow.'
  puts "Usage: '$ ruby tomorrows_rain_forecast.rb <CITY NAME>'"

  return
end

forecast = TomorrowsRainForecastService.new.call(city:)

puts forecast
