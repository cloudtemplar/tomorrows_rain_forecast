# frozen_string_literal: true

require 'faraday'

module OpenWeatherMap
  class ServiceWrapper
    API_URL = 'https://api.openweathermap.org'
    API_KEY = ENV['OPENWEATHER_API_KEY']
    GEOCODING_URL = '/geo/1.0/direct'
    FORECAST_URL = '/data/2.5/forecast'
    # You are getting forecast for 5 days with data every 3 hours, so returning 8 of them
    # results in the last one being a timestamp in ~24 hours.
    TIMESTAMPS_RETURNED = 8

    def initialize
      @conn = Faraday.new(
        url: API_URL,
        params: {
          appid: API_KEY
        }
      )
    end

    def main_weather_in(city:)
      city_coordinates = city_coordinates(city)
      weather_response = weather_response(city_coordinates)

      weather_response['list'].last['weather'].first['main']
    end

    private

    def city_coordinates(city)
      geocoding_response = @conn.get(GEOCODING_URL) do |req|
        req.params['q'] = city
      end

      JSON.parse(geocoding_response.body).first
    end

    def weather_response(city_coordinates)
      weather_response = @conn.get(FORECAST_URL) do |req|
        req.params['cnt'] = TIMESTAMPS_RETURNED
        req.params['lat'] = city_coordinates['lat']
        req.params['lon'] = city_coordinates['lon']
      end

      JSON.parse(weather_response.body)
    end
  end
end
