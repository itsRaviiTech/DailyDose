<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>DailyDose - Weather</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- Fonts & Icons -->
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&family=Poppins:wght@300;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

        <!-- Chart.js -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        <!-- Custom CSS -->
        <link rel="stylesheet" href="weather.css" />
        <link rel="stylesheet" href="layout.css" />
    </head>
    <body>
        <div class="page-wrapper">
            <div class="app-header-card">
                <h1><i class="fas fa-newspaper"></i> DailyDose Weather</h1>
                <p class="subtitle">Accurate weather updates at your fingertips.</p>
            </div>
            <div class="main-container">

                <!-- Weather Search Section -->
                <div class="section">
                    <form action="WeatherServlet" method="post" class="weather-form">
                        <label for="cityName">Enter City:</label><br>
                        <input class="input_txt" type="text" name="cityName" id="cityName" required placeholder="e.g. London" />
                        <input class="input_Search" type="submit" name="submit" value="search" />
                    </form>

                    <!-- Show Errors -->
                    <%
                        boolean invalidCityMsg = request.getAttribute("invalidCityMsg") != null;
                        boolean errorMsg = request.getAttribute("errorMsg") != null;

                        if (invalidCityMsg) {
                    %>
                    <p class="error-msg"><%= request.getAttribute("invalidCityMsg")%></p>
                    <% } else if (errorMsg) {%>
                    <p class="error-msg"><%= request.getAttribute("errorMsg")%></p>
                    <% } %>
                </div>

                <!-- Weather Card -->
                <%
                    if ("search".equals(request.getAttribute("submitValue"))) {
                %>
                <div id="searchedWeather" class="weather-card">
                    <div class="weather-content">
                        <h3>Weather Result</h3>
                        <p>City: <span><%= request.getAttribute("city")%></span></p>
                        <p>Temperature: <span><%= request.getAttribute("temp")%>°C</span></p>
                        <p>Wind Speed: <span><%= request.getAttribute("windSpeed")%> m/s</span></p>
                        <p>Humidity: <span><%= request.getAttribute("humidity")%>%</span></p>
                        <p>Condition: <span><%= request.getAttribute("description")%></span></p>

                        <% String iconUrl = (String) request.getAttribute("iconUrl"); %>
                        <% if (iconUrl != null && !iconUrl.isEmpty()) {%>
                        <img class="weather-icon" src="<%= iconUrl%>" alt="Weather Icon" />
                        <% }%>
                    </div>

                    <canvas
                        id="weatherChart"
                        data-city="<%= request.getAttribute("city")%>"
                        data-temp="<%= request.getAttribute("temp")%>"
                        data-humidity="<%= request.getAttribute("humidity")%>"
                        data-wind="<%= request.getAttribute("windSpeed")%>">
                    </canvas>
                </div>
                <% }%>

<!--                 Back Button 
                <form action="index.jsp">
                    <input type="submit" value="⏪ Back to Home" class="back-btn" />
                </form>-->
            </div>
        </div>
        <jsp:include page="footer.jsp" />

        <!-- Custom Script -->
        <script src="customeWeatherFetcher.js"></script>
    </body>
</html>
