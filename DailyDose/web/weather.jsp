<%-- 
    Document   : weather
    Created on : 2 Jun 2025, 5:35:56 pm
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            h1 {
                color: cornflowerblue;
            }

            .input_txt {
                margin: 0.5em 0;
                height: 2.2em;
                width: 20em;
                border: groove;
                border-color: rgb(119, 158, 230);
                border-radius: 0.4em;
            }

            .input_Search {
                margin: 0.5em 0;
                color: white;
                font-weight: 600;
                width: 20em;
                border: groove;
                border-color: cornflowerblue;
                background-color: cornflowerblue;
                border-radius: 0.4em;
            }

            .input_txt:focus {
                border-color: rgb(40, 108, 233);
                box-shadow: 0 0 8px cornflowerblue;
            }

            .input_Search:hover {
                border-color: rgb(40, 108, 233);
                background-color: rgb(40, 108, 233);
                color: aliceblue;
            }

            .info_box {
                margin: 1em 0;
                border: solid 3px cornflowerblue;
                border-radius: 2em;
            }

            .info_box p {
                margin: 0.5em 2em;
            }

            #searchedWeather {
                position: relative;
            }

            #unitConvert {
                position: absolute;
                top: 10px;
                right: 10px;
                font-size: 0.8rem;
                padding: 0.25rem 0.5rem;
            }
        </style>
    </head>

    <body id="page-weather" class="container mt-3">
        <%
            boolean invalidCityMsg = request.getAttribute("invalidCityMsg") != null;
            boolean errorMsg = request.getAttribute("errorMsg") != null;
        %>

        <div class="text-center">
            <h1>Weather Search</h1>

            <form action="WeatherServlet" method="post" class="d-inline-block mt-3">
                <label for="cityName">Enter City:</label><br>
                <input class="input_txt" type="text" name="cityName" id="cityName" required placeholder="e.g. London"><br>
                <%
                    if (invalidCityMsg) {
                %>
                <p><%= request.getAttribute("invalidCityMsg")%></p>
                <%
                    }
                %>
                <input class="input_Search" type="submit" name="submit" value="search">   
            </form>

            <%
                if ("search".equals(request.getAttribute("submitValue"))) {
            %>
            <!-- Weather result box -->
            <div id="searchedWeather" class="info_box w-50 mx-auto mt-4 p-3 position-relative">
                <p><strong>Weather Result</strong></p>
                <p>City: <span><%= request.getAttribute("city")%></span></p>
                <p>Temperature: <span><%= request.getAttribute("temp")%>°C</span></p>
                <p>Wind Speed: <span><%= request.getAttribute("windSpeed")%> m/s</span></p>
                <p>Humidity: <span><%= request.getAttribute("humidity")%>%</span></p>
                <p>Condition: <span><%= request.getAttribute("description")%></span></p>
                <%
                    String iconUrl = (String) request.getAttribute("iconUrl");
                    String desc = (String) request.getAttribute("description");

                    if (iconUrl != null && !iconUrl.isEmpty()) {
                %>
                <img  style="width:100px; height:100px;" src="<%= iconUrl%>" alt="<%= desc%>" />
                <%
                    }
                %>
            </div>

            <canvas
                id="weatherChart"
                data-city="<%= request.getAttribute("city")%>"
                data-temp="<%=request.getAttribute("temp")%>"
                data-humidity="<%= request.getAttribute("humidity")%>"
                data-wind="<%= request.getAttribute("windSpeed")%>"
                width="100"
                height="75"
                ></canvas>
                <%
                    }
                %>

            <%
                if (errorMsg) {
            %>
            <p class="bg-danger"><strong><%= request.getAttribute("errorMsg")%></strong></p>
                    <%}%>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="customeWeatherFetcher.js"></script>
    </body>
</html>
