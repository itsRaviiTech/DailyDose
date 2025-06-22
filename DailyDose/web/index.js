/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

console.log("indexWeather.js loaded");

document.addEventListener("DOMContentLoaded", function () {
    let weatherDataGlobal = null;
    let useImperial = false;

    // Location detection only if element exists
    if (navigator.geolocation && document.getElementById("weather")) {
        navigator.geolocation.getCurrentPosition(success, error);
    }

    // Unit convert button (only works after data is fetched)
    const unitBtn = document.getElementById("unitConvert");
    if (unitBtn) {
        unitBtn.addEventListener("click", function () {
            useImperial = !useImperial;
            updateWeatherBox();
            this.innerText = useImperial ? "Switch to Metric" : "Switch to Imperial";
        });
    }

    function success(position) {
        const lat = position.coords.latitude;
        const lon = position.coords.longitude;

        fetch(`WeatherServlet?lat=${lat}&lon=${lon}`)
            .then(response => response.json())
            .then(data => {
                if (data.weather) {
                    weatherDataGlobal = data;
                    updateWeatherBox();
                } else {
                    document.getElementById("weather").innerText = "Unable to fetch weather data.";
                }
            })
            .catch(() => {
                document.getElementById("weather").innerText = "Error fetching weather data.";
            });
    }

    function error() {
        document.getElementById("weather").innerText = "Unable to get your location.";
    }

    function updateWeatherBox() {
        const data = weatherDataGlobal;
        if (!data) return;

        const iconCode = data.weather[0].icon;
        const iconUrl = `http://openweathermap.org/img/wn/${iconCode}@2x.png`;

        const temp = useImperial
            ? (data.main.temp * 9 / 5 + 32).toFixed(2) + "°F"
            : data.main.temp + "°C";

        const wind = useImperial
            ? (data.wind.speed * 2.23694).toFixed(2) + " mph"
            : data.wind.speed + " m/s";

        const avgTemp = useImperial
            ? ((data.main.temp_min * 9 / 5 + 32 + data.main.temp_max * 9 / 5 + 32) / 2).toFixed(2) + "°F"
            : ((data.main.temp_min + data.main.temp_max) / 2).toFixed(2) + "°C";

        document.getElementById("weather").innerHTML = `
            <p><strong>City:</strong> ${data.name}</p>
            <p><strong>Temperature:</strong> ${temp}</p>
            <p><strong>Wind Speed:</strong> ${wind}</p>
            <p><strong>Humidity:</strong> ${data.main.humidity}%</p>
            <p><strong>Average Temp:</strong> ${avgTemp}</p>
            <p><strong>Condition:</strong> ${data.weather[0].description}</p>
            <img style="width:100px;height:100px;" src="${iconUrl}" alt="${data.weather[0].description}"/>`;
    }
});

