/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

public class WeatherFetcher {

    public static String fetchWeather(String city, String apiKey) throws IOException {

        HttpURLConnection conn = null;
        BufferedReader in = null;

        try {

            String encodedCity = URLEncoder.encode(city, StandardCharsets.UTF_8);

            // Construct the API URL with city name, API key, and metric units
            String urlString = "https://api.openweathermap.org/data/2.5/weather?q="
                    + encodedCity + "&appid=" + apiKey + "&units=metric";

            // Create a URL object from the string
            URL url = new URL(urlString);

            // Open an HTTP connection to the API endpoint
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            int status = conn.getResponseCode();

            // Choose the correct stream: InputStream for 200 OK, ErrorStream otherwise
            InputStreamReader streamReader;
            if (status >= 200 && status < 300) {
                streamReader = new InputStreamReader(conn.getInputStream());
            } else {
                streamReader = new InputStreamReader(conn.getErrorStream());
            }

            in = new BufferedReader(streamReader);
            String inputLine;
            StringBuilder content = new StringBuilder();
            while ((inputLine = in.readLine()) != null) {
                content.append(inputLine);
            }

            return content.toString();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (in != null) {
                in.close();
            }
            if (conn != null) {
                conn.disconnect();
            }
        }
    }
    
    public static String getWeather_userLocation(String lat, String lon , String apiKey ) throws IOException {
        
        String urlString = "https://api.openweathermap.org/data/2.5/weather?lat=" +
                lat + "&lon=" + lon + "&appid=" + apiKey + "&units=metric";

        URL url = new URL(urlString);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        Scanner sc = new Scanner(conn.getInputStream());
        StringBuilder json = new StringBuilder();
        while (sc.hasNext()) {
            json.append(sc.nextLine());
        }
        sc.close();

        return json.toString();
    }

}

