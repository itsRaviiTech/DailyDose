<%-- 
    Document   : index
    Created on : 2 Jun 2025, 4:34:39 pm
    Author     : 
--%>

<%@ page import="model.AdviceBean" %>
<%@ page import="model.WeatherBean" %>
<%@ page import="model.NewsBean" %>
<%@ page import="model.NewsBean.NewsArticle" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Instantiate your beans
    AdviceBean adviceBean = new AdviceBean();
    WeatherBean weatherBean = new WeatherBean(); // Use default city or modify constructor to accept city
    NewsBean newsBean = new NewsBean();
    java.util.List<NewsArticle> articles = newsBean.getArticles();
%>
<html>
<head>
    <title>DailyDose - Home</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles.css" />
</head>
<body>
<div class="container">

    <h1 class="app-title">DailyDose</h1>

    <%-- Advice Card --%>
    <div class="card advice-card">
        <p class="advice-text">“<%= adviceBean.getAdvice() %>”</p>
        <form method="get" class="refresh-form">
            <button type="submit" class="refresh-btn">Refresh Advice</button>
        </form>
    </div>

    <%-- Weather Card --%>
    <div class="card weather-card">
        <h3>Current Weather</h3>
        <p><strong>City:</strong> <%= weatherBean.getCity() %></p>
        <p><strong>Temperature:</strong> <%= weatherBean.getTemperature() %> (<%= weatherBean.getWeatherDesc() %>)</p>
        <p><strong>Wind Speed:</strong> <%= weatherBean.getWindSpeed() %></p>
        <p><strong>Humidity:</strong> <%= weatherBean.getHumidity() %></p>
    </div>

    <%-- News Card --%>
    <div class="card news-card">
        <h3>Top News Headlines</h3>
        <ul>
            <% for(NewsArticle article : articles) { %>
                <li>
                    <a href="<%= article.getUrl() %>" target="_blank" class="news-link">
                        <%= article.getTitle() %>
                    </a><br/>
                    <small><%= article.getSource() %> - <%= article.getPublishedDate() %></small>
                </li>
            <% } %>
        </ul>
    </div>

</div>

<%-- Bottom Navigation Bar --%>
<nav class="bottom-nav">
    <a href="index.jsp" class="nav-link active">Home</a>
    <a href="weather.jsp" class="nav-link">Weather</a>
    <a href="news.jsp" class="nav-link">News</a>
</nav>

</body>
</html>
