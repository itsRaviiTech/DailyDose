package controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import java.util.*;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import org.json.*;
import model.WeatherFetcher;

/**
 *
 * @author HP
 */
public class WeatherServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String API_KEY = "44622060ec113afc26436633d8c49dfe";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String lat = request.getParameter("lat");
        String lon = request.getParameter("lon");

        // Let the model handle the API construction and data retrieval
        String json = WeatherFetcher.getWeather_userLocation(lat, lon, API_KEY);

        response.setContentType("application/json");
        response.getWriter().write(json);

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String lat = request.getParameter("lat");
        String lon = request.getParameter("lon");

        // Let the model handle the API construction and data retrieval
        String json = WeatherFetcher.getWeather_userLocation(lat, lon, API_KEY);

        response.setContentType("application/json");
        response.getWriter().write(json);

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String submitValue = request.getParameter("submit");
        String city = request.getParameter("cityName");
        try {
            String weatherData = WeatherFetcher.fetchWeather(city, API_KEY); // helper class

            if (weatherData == null || weatherData.isEmpty()) {
                request.setAttribute("errorMsg", "Empty response from weather server.");
                request.getRequestDispatcher("weather.jsp").forward(request, response);
                return;
            }

            // Parse weatherData (JSON) using org.json or Gson
            JSONObject obj = new JSONObject(weatherData);

            String cod = obj.get("cod").toString();
            if (!"200".equals(cod)) {
                request.setAttribute("invalidCityMsg", "Invalid City name");
                request.getRequestDispatcher("weather.jsp").forward(request, response);
                return;
            }

            JSONObject main = obj.getJSONObject("main");
            JSONObject wind = obj.getJSONObject("wind");
            JSONArray weatherArray = obj.getJSONArray("weather");
            JSONObject weather = weatherArray.getJSONObject(0);

            //if the city not found or invalid city
            double temp = main.getDouble("temp");
            int humidity = main.getInt("humidity");
            String iconCode = weather.getString("icon"); // ✅ get icon code
            String description = obj.getJSONArray("weather").getJSONObject(0).getString("description");

            double windSpeed = wind.getDouble("speed");

            // Prepare full icon URL (you can also do this in JSP)
            String iconUrl = "https://openweathermap.org/img/wn/" + iconCode + "@2x.png";

            request.setAttribute("city", city);
            request.setAttribute("temp", temp);
            request.setAttribute("humidity", humidity);
            request.setAttribute("windSpeed", windSpeed);
            request.setAttribute("description", description);
            request.setAttribute("iconUrl", iconUrl);
            request.setAttribute("submitValue", submitValue);
            request.getRequestDispatcher("weather.jsp").forward(request, response);
        } catch (Exception e) {
            // Handles parsing or null exceptions
            request.setAttribute("errorMsg", "Something went wrong. Please try again.");
            request.getRequestDispatcher("weather.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
