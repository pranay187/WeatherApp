require 'rails_helper'

RSpec.describe ForecastController, type: :controller do
  describe "GET #index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #show" do
    context "with valid address" do
      it "redirects to weather_path with lat and lon" do
        fake_result = double("Geocoder result", data: { "lat" => "40.7128", "lon" => "-74.0060" })
        allow(Geocoder).to receive(:search).with("New York").and_return([fake_result])

        get :show, params: { address: "New York" }

        expect(response).to redirect_to(weather_path(lat: "40.7128", lon: "-74.0060"))
      end
    end

    context "with invalid address" do
      it "redirects to root_path with alert" do
        allow(Geocoder).to receive(:search).with("InvalidCity").and_return([])

        get :show, params: { address: "InvalidCity" }

        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("Invalid address")
      end
    end
  end

  describe "GET #show_weather" do
    let(:lat) { "40.7128" }
    let(:lon) { "-74.0060" }
    let(:cache_key) { "forecast_#{lat}_#{lon}" }

    let(:mock_forecast) do
      {
        "main" => { "temp" => 22, "temp_max" => 28, "temp_min" => 18 },
        "weather" => [{ "description" => "Partly cloudy" }]
      }
    end

    context "when data is cached" do
      before do
        Rails.cache.write(cache_key, mock_forecast)
      end

      it "fetches forecast from cache and assigns @from_cache" do
        get :show_weather, params: { lat: lat, lon: lon }

        expect(assigns(:forecast)).to eq(mock_forecast)
        expect(assigns(:from_cache)).to be true
        expect(response).to have_http_status(:ok)
      end
    end

    context "when data is not cached" do
      before { Rails.cache.delete(cache_key) }

      it "calls WeatherFetcher and caches result" do
        allow(WeatherFetcher).to receive(:new).with(lat: lat, lon: lon).and_return(double(call: mock_forecast))

        get :show_weather, params: { lat: lat, lon: lon }

        expect(assigns(:forecast)).to eq(mock_forecast)
        expect(assigns(:from_cache)).to be false
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
