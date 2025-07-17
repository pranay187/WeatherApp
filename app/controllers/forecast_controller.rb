class ForecastController < ApplicationController
  def index
  end

  # Converts the address to coordinates (lat/lon) and redirects to show_weather action
  def show
    address = params[:address]
    coordinates = extract_coordinates(address)

    if coordinates.present?
      redirect_to weather_path(lat: coordinates[:lat], lon: coordinates[:lon])
    else
      flash[:alert] = "Invalid address"
      redirect_to root_path
    end
  end

  # Displays weather information based on lat/lon (passed in params)
  def show_weather
    lat = params[:lat]
    lon = params[:lon]
    cache_key = "forecast_#{lat}_#{lon}"

    @from_cache = Rails.cache.exist?(cache_key)
    @forecast = Rails.cache.fetch(cache_key, expires_in: 30.minutes) do
      WeatherFetcher.new(lat: lat, lon: lon).call
    end
  end

  private

  # Looks up the address and returns coordinates (lat, lon)
  def extract_coordinates(address)
    result = Geocoder.search(address)&.first

    if result.present?
      {
        lat: result&.data["lat"],
        lon: result&.data["lon"]
      }
    else
      nil
    end
  end
end
