<%@ page import="model.AdviceBean" %>
<%@ page import="model.WeatherBean" %>
<%@ page import="model.NewsBean" %>
<%@ page import="model.NewsBean.NewsArticle" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Instantiate your beans
    AdviceBean adviceBean = new AdviceBean();
    WeatherBean weatherBean = new WeatherBean();
    NewsBean newsBean = new NewsBean();

    java.util.List<NewsArticle> articles = newsBean.getArticles();

    // Date formatting
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); // Date format pattern
%>

<html>
    <head>
        <title>DailyDose - Home</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css" />
    </head>
    <body id="page-index">
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
                <p id="weather">Detecting your location...</p>
                <button type="button" id="unitConvert" class="refresh-btn">Convert Units</button>
            </div>

            <%-- News Card --%>
            <div class="card news-card">
                <h3>Top News Headlines</h3>
                <ul>
                    <% for (NewsArticle article : articles) { %>
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

        <nav class="bottom-nav">
            <a href="index.jsp" class="nav-link active">Home</a>
            <a href="weather.jsp" class="nav-link">Weather</a>
            <a href="news.jsp" class="nav-link">News</a>
            <a href="googleCalendar.jsp" class="nav-link">Calendar</a>
        </nav>

        <script src="index.js"></script>
    </body>
</html>
