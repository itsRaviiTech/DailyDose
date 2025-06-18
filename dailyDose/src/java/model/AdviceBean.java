/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import org.json.JSONObject;

public class AdviceBean {
    private String advice;

    public String getAdvice() {
        try {
            URL url = new URL("https://api.adviceslip.com/advice");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder json = new StringBuilder();
            String line;

            while ((line = in.readLine()) != null) {
                json.append(line);
            }
            in.close();

            JSONObject obj = new JSONObject(json.toString());
            advice = obj.getJSONObject("slip").getString("advice");
        } catch (Exception e) {
            advice = "Unable to fetch advice. Please check your internet connection.";
        }

        return advice;
    }
}
