/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
console.log("customeWeatherFetcher.js loaded");

document.addEventListener("DOMContentLoaded", function () {
    let useImperial = false;
    let chartInstance = null;

    const chartCanvas = document.getElementById("weatherChart");
    const weatherBox = document.getElementById("searchedWeather");

    const city = chartCanvas?.dataset.city;
    const tempC = parseFloat(chartCanvas?.dataset.temp || 0);
    const humidity = parseFloat(chartCanvas?.dataset.humidity || 0);
    const windSpeedMs = parseFloat(chartCanvas?.dataset.wind || 0);

    const unitBtn = document.createElement("button");
    unitBtn.id = "unitConvert";
    unitBtn.className = "btn btn-sm btn-outline-primary";
    unitBtn.innerText = "Switch to Imperial";
    weatherBox?.appendChild(unitBtn);

    unitBtn.addEventListener("click", () => {
        useImperial = !useImperial;
        updateWeatherBox();
        updateChart();
        unitBtn.innerText = useImperial ? "Switch to Metric" : "Switch to Imperial";
    });

    function updateWeatherBox() {
        if (!weatherBox) return;

        const temp = useImperial ? (tempC * 9 / 5 + 32).toFixed(2) + "°F" : tempC + "°C";
        const wind = useImperial ? (windSpeedMs * 2.23694).toFixed(2) + " mph" : windSpeedMs + " m/s";

        const spans = weatherBox.querySelectorAll("span");
        spans[1].innerText = temp;
        spans[2].innerText = wind;
    }

    function updateChart() {
        if (!chartCanvas || !city) return;

        // Example: Use Malaysia lat/lon if you don't have exact values from backend
        const dummyLat = 5.4171;
        const dummyLon = 103.1029;

        const apiKey = "44622060ec113afc26436633d8c49dfe";
        const url = `https://api.openweathermap.org/data/2.5/forecast?q=${city}&appid=${apiKey}&units=metric`;

        fetch(url)
            .then(res => res.json())
            .then(data => {
                const labels = [];
                const temps = [];
                const winds = [];
                const humidities = [];

                data.list.slice(0, 8).forEach(entry => {
                    const time = entry.dt_txt.substring(11, 16);
                    labels.push(time);

                    const temp = useImperial ? (entry.main.temp * 9 / 5 + 32) : entry.main.temp;
                    const wind = useImperial ? (entry.wind.speed * 2.23694) : entry.wind.speed;

                    temps.push(temp);
                    winds.push(wind);
                    humidities.push(entry.main.humidity);
                });

                const ctx = chartCanvas.getContext("2d");

                if (chartInstance) chartInstance.destroy();

                chartInstance = new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: labels,
                        datasets: [
                            {
                                label: `Temperature (${useImperial ? "°F" : "°C"})`,
                                data: temps,
                                borderColor: 'rgba(255, 99, 132, 1)',
                                backgroundColor: 'rgba(255, 99, 132, 0.2)',
                                tension: 0.4
                            },
                            {
                                label: `Humidity (%)`,
                                data: humidities,
                                borderColor: 'rgba(54, 162, 235, 1)',
                                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                                tension: 0.4
                            },
                            {
                                label: `Wind Speed (${useImperial ? "mph" : "m/s"})`,
                                data: winds,
                                borderColor: 'rgba(255, 206, 86, 1)',
                                backgroundColor: 'rgba(255, 206, 86, 0.2)',
                                tension: 0.4
                            }
                        ]
                    },
                    options: {
                        responsive: true,
                        plugins: {
                            title: {
                                display: true,
                                text: `24-Hour Forecast for ${city}`
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: false
                            }
                        }
                    }
                });
            })
            .catch(err => console.error("Forecast fetch error:", err));
    }

    updateChart(); // initial draw
});
