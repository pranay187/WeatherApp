class WeatherFetcher
  include HTTParty
  base_uri 'https://api.openweathermap.org/data/2.5'

  # Sets up the weather fetcher with latitude and longitude for a specific location
  def initialize(lat:, lon:)
    @lat = lat
    @lon = lon
    @api_key = Rails.application.credentials.dig(:openweather, :api_key)
  end

  # This gets the weather data from the API
  def call
    self.class.get("/weather", query: {
      lat: @lat,
      lon: @lon,
      appid: @api_key,
      units: 'metric'
    }).parsed_response
  end
end
