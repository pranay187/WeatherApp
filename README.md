# 🌦️ Weather Forecast APP(Ruby on Rails)

## 📌 Overview
This is a **Ruby on Rails API** that provides real-time weather forecasts for any location.

It uses:
- 🗺️ **Geocoder** – to convert addresses into latitude & longitude
- 🌐 **OpenWeather API** – to fetch current weather data
- 🧠 **Rails built-in cache** – to reduce API calls (in-memory by default)

---

## ⚙️ Features

✅ Enter any city or address (e.g., `Hyderabad`, `London`)

✅ Automatically geocodes the address to latitude & longitude

✅ Fetches and displays:
  - Current temperature
  - High / Low temperatures
  - Weather description
  - Whether result was cached

✅ Caches API results **in memory** (using `Rails.cache`) for **30 minutes**

✅ Handles invalid addresses gracefully

✅ Includes RSpec test coverage
 
---

## 🛠️ Installation

### 1️⃣ Clone the Repository
```bash
git clone <your-repo-url>
cd weather_app

### **2️⃣ Install Dependencies**
```sh
bundle install
```

### **3️⃣ Set Up Environment Variables**
- Add your **OpenWeather API Key** in Rails credentials:
```sh
rails credentials:edit
```
Then add:
```yaml
weather_api_key: YOUR_OPENWEATHER_API_KEY
```


### **5️⃣ Run the Rails Server**
```sh
rails server
```
The API will now be available at **`http://localhost:3000`**.

🔗 API Flow Summary
1.Home page (GET /)
→ Displays a form to enter an address or city.

2.Form submission (POST /forecast/show)
→ Controller extracts coordinates using Geocoder, then redirects.

3.Weather page (GET /weather)
→ Fetches weather data via WeatherFetcher, caches results using Rails.cache, and renders them in show_weather.html.erb.

![alt text](<Screenshot 2025-07-17 at 3.10.12 PM.png>)

![alt text](<Screenshot 2025-07-17 at 3.10.26 PM.png>)


---

## 🏗️ Tech Stack
- **Ruby on Rails** (API Mode)
- **HTTParty** (API Requests)
- **Geocoder** (Address to Lat/Lon)
- **Rails Cache** (MemoryStore)
- **RSpec** (Testing)
- **ERB** (rendering views)

---

## 📜 License
The OpenWeather API used in this project has a free usage tier that limits requests to 1,000 calls per day. Please ensure your usage stays within these limits or consider upgrading your OpenWeather account for higher usage.

---

## ✨ Author
Developed by **[Pranay Mudrakola]** 🚀

---

## Additional Points
 - Added a CI/CD pipeline which run spec and shows the status on the gitlab branch.(DONE)
 - Would love to build more on it like:(Pending)
   - Build a UI(graphs and visuals)
   - Add location autocomplete
   - houlry wheather updates on the page for frequenly searched locations
   - historical weather data
