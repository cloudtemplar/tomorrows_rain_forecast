# frozen_string_literal: true

require_relative 'open_weather_map/service_wrapper'

class TomorrowsRainForecastService
  def initialize(weather_service: OpenWeatherMap::ServiceWrapper.new)
    @weather_service = weather_service
  end

  def call(city:)
    main_weather = weather_service.main_weather_in(city: city)

    if main_weather == 'Rain'
      "It will rain tomorrow in #{city}"
    else
      "It won't rain tomorrow in #{city}"
    end
  end

  private

  attr_reader :weather_service
end
