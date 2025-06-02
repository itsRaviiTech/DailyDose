/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


// Check if the browser supports geolocation
if (navigator.geolocation) {
  // Try to get the user's current position
  navigator.geolocation.getCurrentPosition(success, error);
} else {
  // Geolocation not supported
  document.getElementById("weather").innerText = "Geolocation is not supported by your browser.";
}

// Runs when location is successfully obtained
function success(position) {
  const lat = position.coords.latitude;
  const lon = position.coords.longitude;

  // Send lat/lon to the Java Servlet
  fetch(`WeatherServlet?lat=${lat}&lon=${lon}`)
    .then(response => response.json()) // Parse JSON from server
    .then(data => {
      if (data.weather) {
          const iconCode = data.weather[0].icon;
          const iconUrl = `http://openweathermap.org/img/wn/${iconCode}@2x.png`;
          console.log("Icon URL:", iconUrl);
        // Show weather info
        document.getElementById("weather").innerHTML =
          `<strong>City:</strong> ${data.name} <br>
           <strong>Temperature:</strong> ${data.main.temp}°C<br>
           <strong>Wind Speed:</strong> ${data.wind.speed}<br>
           <strong>Humidity:</strong> ${data.main.humidity}<br>
           <strong>Condition</strong> ${data.weather[0].description}<br>
           <img src="${iconUrl}" alt="Weather Icon"><br>
           `;
      } else {
        document.getElementById("weather").innerText = "Unable to fetch weather data.";
      }
    })
    .catch(() => {
      document.getElementById("weather").innerText = "Error fetching weather data.";
    });
}

// Runs if the location could not be retrieved
function error() {
  document.getElementById("weather").innerText = "Unable to get your location.";
}
