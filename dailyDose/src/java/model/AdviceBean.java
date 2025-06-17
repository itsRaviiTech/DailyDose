package model;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import org.json.JSONObject;

public class AdviceBean {

    private String advice;

    // Get default advice (general advice) from the random advice endpoint
    public String getAdvice() {
        return fetchAdvice("https://api.adviceslip.com/advice"); // Always random advice endpoint
    }

    // Get advice based on search query (category-based or any other search term)
    public String getAdviceByCategory(String category) {
        // Default to "general" if category is not recognized
        if (category == null || category.isEmpty()) {
            category = "general";  // Default to "general" if nothing is selected
        }

        // Map categories to search query
        String query = getCategoryQuery(category);

        // Force new advice by hitting the random advice endpoint
        String endpoint = "https://api.adviceslip.com/advice";

        // Get the advice from the API
        String fetchedAdvice = fetchAdvice(endpoint);

        // If no advice is found for the category (empty response), fetch random advice again
        if (fetchedAdvice.isEmpty()) {
            return fetchAdvice("https://api.adviceslip.com/advice"); // Always fetch random advice
        }

        return fetchedAdvice;
    }

    // Helper method to map the category to search terms
    private String getCategoryQuery(String category) {
        switch (category.toLowerCase()) {
            case "life":
                return "life";
            case "success":
                return "success";
            case "happiness":
                return "happiness";
            case "joy":
                return "joy";
            case "lesson":
                return "lesson";
            case "experience":
                return "experience";
            case "work":
                return "work";
            case "regret":
                return "regret";
            default:
                return "general"; // Default search term for unknown categories
        }
    }

    // Helper method to fetch advice (random or specific)
    private String fetchAdvice(String endpoint) {
        try {
            URL url = new URL(endpoint);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            StringBuilder json;
            try (BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
                json = new StringBuilder();
                String line;
                while ((line = in.readLine()) != null) {
                    json.append(line);
                }
            }

            // Parse the response and check if advice is available
            JSONObject obj = new JSONObject(json.toString());

            // Check if the "slips" array is present and not empty
            if (obj.has("slips") && obj.getJSONArray("slips").length() > 0) {
                advice = obj.getJSONArray("slips").getJSONObject(0).getString("advice");
            } else {
                advice = ""; // If no advice is found, set as empty (trigger fallback)
            }
        } catch (Exception e) {
            advice = ""; // Set to empty if an error occurs (will fetch random advice)
            e.printStackTrace();  // Log the exception for debugging
        }

        // Return either fetched advice or fallback random advice (if empty)
        return advice.isEmpty() ? fetchAdvice("https://api.adviceslip.com/advice") : advice; // Fetch random advice if empty
    }
}
