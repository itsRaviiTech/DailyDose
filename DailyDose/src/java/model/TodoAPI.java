/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author User
 */


import org.json.JSONArray;
import org.json.JSONObject;
import org.apache.hc.client5.http.impl.classic.CloseableHttpClient;
import org.apache.hc.client5.http.impl.classic.HttpClients;
import org.apache.hc.client5.http.impl.classic.CloseableHttpResponse;
import org.apache.hc.client5.http.classic.methods.HttpGet;
import org.apache.hc.client5.http.classic.methods.HttpPost;
import org.apache.hc.core5.http.HttpEntity;
import org.apache.hc.core5.http.io.entity.StringEntity;
import org.apache.hc.core5.http.io.entity.EntityUtils;

public class TodoAPI {

    // GET method to fetch to-do tasks and return as a JSONArray
    public String fetchTasks() {
    String url = "https://jsonplaceholder.typicode.com/todos";
    try (CloseableHttpClient httpClient = HttpClients.createDefault()) {
        HttpGet request = new HttpGet(url);  // Create a GET request
        try (CloseableHttpResponse response = httpClient.execute(request)) {
            if (response.getCode() == 200) {  // Check if the response status is OK (200)
                HttpEntity entity = response.getEntity();
                String result = EntityUtils.toString(entity);  // Get response as a String
                return result;  // Return the response as a String
            } else {
                System.out.println("Error fetching tasks. Status Code: " + response.getCode());
                return "Error fetching tasks";  // Return an error message
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        return "Error: Unable to fetch tasks.";  // Return an error message
    }
}


    // POST method to create a new to-do task and return the created task as a JSON object
    public JSONObject createTask(String title, boolean completed) {
        String url = "https://jsonplaceholder.typicode.com/todos";
        try (CloseableHttpClient httpClient = HttpClients.createDefault()) {
            HttpPost request = new HttpPost(url);  // Create a POST request
            // Create the JSON string with title and completed status
            String json = String.format("{\"title\":\"%s\",\"completed\":%b,\"userId\":1}", title, completed);
            StringEntity entity = new StringEntity(json);  // Set JSON string as the entity for the POST request
            request.setEntity(entity);
            request.setHeader("Content-Type", "application/json");  // Set the content type to JSON

            try (CloseableHttpResponse response = httpClient.execute(request)) {
                if (response.getCode() == 201) {  // Check if the response status is Created (201)
                    HttpEntity responseEntity = response.getEntity();
                    String result = EntityUtils.toString(responseEntity);
                    return new JSONObject(result);  // Return the created task as a JSONObject
                } else {
                    System.out.println("Error creating task. Status Code: " + response.getCode());
                    return new JSONObject();  // Return an empty JSON object in case of error
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new JSONObject();  // Return an empty JSON object in case of exception
        }
    }
}
