/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author User
 */



import org.json.JSONObject;
import org.apache.hc.client5.http.classic.methods.HttpGet;
import org.apache.hc.client5.http.impl.classic.CloseableHttpClient;
import org.apache.hc.client5.http.impl.classic.CloseableHttpResponse;
import org.apache.hc.client5.http.impl.classic.HttpClients;
import org.apache.hc.core5.http.HttpEntity;
import org.apache.hc.core5.http.io.entity.EntityUtils;

public class JokeBean {

    private String joke;

    // Default constructor
    public JokeBean() {
        this.joke = "";
    }

    // Getter for the joke
    public String getJoke() {
        return joke;
    }

    // Setter for the joke (optional)
    public void setJoke(String joke) {
        this.joke = joke;
    }

    // Method to fetch a random joke from JokeAPI based on category and type
    public void fetchJoke(String category, String type) {
        String url = "https://v2.jokeapi.dev/joke/" + category + "?type=" + type;  // JokeAPI URL

        // Create an HttpClient
        try (CloseableHttpClient httpClient = HttpClients.createDefault()) {
            // Send GET request
            HttpGet request = new HttpGet(url);

            // Execute the request and get the response
            try (CloseableHttpResponse response = httpClient.execute(request)) {
                // Get the status code using getCode() method in HttpClient 5.x
                int statusCode = response.getCode();

                // Check if the request was successful
                if (statusCode == 200) {
                    // Parse the response
                    HttpEntity entity = response.getEntity();
                    String result = EntityUtils.toString(entity);

                    // Parse JSON response using org.json.JSONObject
                    JSONObject jsonResponse = new JSONObject(result);
                    if (jsonResponse.has("joke")) {
                        this.joke = jsonResponse.getString("joke"); // For single-part jokes
                    } else if (jsonResponse.has("setup") && jsonResponse.has("delivery")) {
                        String setup = jsonResponse.getString("setup");
                        String delivery = jsonResponse.getString("delivery");
                        this.joke = setup + " " + delivery; // For two-part jokes
                    }
                } else {
                    this.joke = "Error fetching joke. Status Code: " + statusCode;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            this.joke = "Error: Unable to fetch joke.";
        }
    }
}
