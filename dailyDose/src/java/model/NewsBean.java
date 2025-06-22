/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.*;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URLEncoder;
import java.net.URL;
import org.json.JSONArray;
import org.json.JSONObject;
import java.util.ArrayList;
import java.util.List;

public class NewsBean {

    private static final String API_KEY = "355688773bbb194f30bdca5f355de288";
    private List<NewsArticle> articles;
    //for data processing stuff
    private Map<String, List<NewsArticle>> groupedBySource;
    private Map<String, Integer> keywordFrequency;

    // Default constructor (top headlines in English)
    public NewsBean() {
        fetchNews("latest", "en", "my");
    }

    // Overloaded constructor for custom search
    public NewsBean(String keyword, String language, String country) {
        if (keyword == null || keyword.trim().isEmpty()) {
            keyword = "latest"; // fallback if no keyword
        }
        if (language == null || language.isEmpty()) {
            language = "en";
        }
        if (country == null || country.isEmpty()) {
            country = "my";
        }
        fetchNews(keyword, language, country);
    }

    private void fetchNews(String keyword, String language, String country) {
        articles = new ArrayList<>();
        groupedBySource = new HashMap<>();
        keywordFrequency = new HashMap<>();

        try {
            keyword = URLEncoder.encode(keyword, "UTF-8");
            String apiUrl = "https://gnews.io/api/v4/search?q=" + keyword
                    + "&lang=" + language
                    + "&country=" + country
                    + "&max=10&token=" + API_KEY;

            URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            BufferedReader in = new BufferedReader(
                    new InputStreamReader(conn.getInputStream())
            );
            StringBuilder response = new StringBuilder();
            String inputLine;
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            JSONObject obj = new JSONObject(response.toString());
            JSONArray newsArray = obj.getJSONArray("articles");

            for (int i = 0; i < Math.min(newsArray.length(), 10); i++) {
                JSONObject item = newsArray.getJSONObject(i);
                String title = item.getString("title");
                String source = item.getJSONObject("source").getString("name");
                String publishedAt = item.getString("publishedAt").split("T")[0];
                String urlLink = item.getString("url");

                NewsArticle article = new NewsArticle(title, source, publishedAt, urlLink);
                articles.add(article);

                // --- GROUPING ---
                groupedBySource.computeIfAbsent(source, k -> new ArrayList<>()).add(article);

                // --- KEYWORD COUNT ---
                String[] words = title.toLowerCase().split("\\W+");
                for (String word : words) {
                    if (word.length() > 2 && !isStopWord(word)) {
                        keywordFrequency.put(word, keywordFrequency.getOrDefault(word, 0) + 1);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            articles.add(new NewsArticle("Unable to fetch news", "", "", "#"));
        }
    }

    // Stopwords helper
    private boolean isStopWord(String word) {
        String[] stopwords = {"the", "and", "for", "you", "with", "from", "this", "that", "have", "has", "are", "was", "will", "not"};
        return Arrays.asList(stopwords).contains(word);
    }

    public List<NewsArticle> getArticles() {
        return articles;
    }

    public Map<String, List<NewsArticle>> getGroupedBySource() {
        return groupedBySource;
    }

    public List<String> getTopKeywords(int topN) {
        return keywordFrequency.entrySet().stream()
                .sorted((a, b) -> b.getValue() - a.getValue())
                .limit(topN)
                .map(Map.Entry::getKey)
                .toList();
    }

    // Inner class for news article
    public static class NewsArticle {

        private String title, source, publishedDate, url;

        public NewsArticle(String title, String source, String publishedDate, String url) {
            this.title = title;
            this.source = source;
            this.publishedDate = publishedDate;
            this.url = url;
        }

        public String getTitle() {
            return title;
        }

        public String getSource() {
            return source;
        }

        public String getPublishedDate() {
            return publishedDate;
        }

        public String getUrl() {
            return url;
        }
    }
}
