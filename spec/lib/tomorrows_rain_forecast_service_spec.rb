# frozen_string_literal: true

require 'tomorrows_rain_forecast_service'

describe TomorrowsRainForecastService do
  describe '#call' do
    subject(:call) do
      described_class.new(weather_service: weather_service_instance)
                     .call(city:)
    end

    let(:weather_service_instance) { instance_double(OpenWeatherMap::ServiceWrapper) }
    let(:city) { 'Paris' }

    context 'when its raining in the specified city' do
      let(:main_weather_tomorrow) { 'Rain' }

      before do
        allow(weather_service_instance).to receive(:main_weather_in).with(city:).and_return(main_weather_tomorrow)
      end

      it 'returns forecast' do
        expect(call).to eq "It will rain tomorrow in #{city}"
      end
    end

    context 'when its not raining in the specified city' do
      let(:main_weather_tomorrow) { 'Snow' }

      before do
        allow(weather_service_instance).to receive(:main_weather_in).with(city:).and_return(main_weather_tomorrow)
      end

      it 'returns forecast' do
        expect(call).to eq "It won't rain tomorrow in #{city}"
      end
    end
  end
end
