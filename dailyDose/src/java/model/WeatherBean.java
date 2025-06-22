/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import org.json.JSONObject;
import org.json.JSONArray;

public class WeatherBean {

    private static final String API_KEY = "YOUR_OPENWEATHERMAP_API_KEY";

    private String city;
    private String temperature;
    private String windSpeed;
    private String humidity;
    private String weatherDesc;
    private String icon;

    public WeatherBean() {
        // Default city for demo
        this.city = "Kuala Lumpur";
        fetchWeather();
    }

    public WeatherBean(String city) {
        this.city = city;
        fetchWeather();
    }

    private void fetchWeather() {
        try {
            String apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=" 
                            + city + "&units=metric&appid=" + API_KEY;

            URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            BufferedReader in = new BufferedReader(
                    new InputStreamReader(conn.getInputStream())
            );
            String inputLine;
            StringBuilder response = new StringBuilder();

            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            JSONObject obj = new JSONObject(response.toString());

            this.temperature = obj.getJSONObject("main").getDouble("temp") + "°C";
            this.humidity = obj.getJSONObject("main").getInt("humidity") + "%";
            this.windSpeed = obj.getJSONObject("wind").getDouble("speed") + " m/s";
            this.weatherDesc = obj.getJSONArray("weather").getJSONObject(0).getString("description");
            
            JSONArray weatherArray = obj.getJSONArray("weather");
            this.icon =  weatherArray.getJSONObject(0).getString("icon");
            

        } catch (Exception e) {
            this.temperature = "--";
            this.humidity = "--";
            this.windSpeed = "--";
            this.weatherDesc = "Unable to fetch weather";
            this.icon = ""; // fallback to empty string if fetch fails
        }
    }

    // Getters
    public String getCity() { 
        return city; 
    }
    
    public String getTemperature() { 
        return temperature; 
    }
    
    public String getHumidity() { 
        return humidity; 
    }
    
    public String getWindSpeed() { 
        return windSpeed; 
    }
    
    public String getWeatherDesc() {
        return weatherDesc;
    }

    public String getIcon() {
        return icon;
    }
    
     public String getIconUrl() {
        return "https://openweathermap.org/img/wn/" + icon + "@2x.png";
    }
     
}
