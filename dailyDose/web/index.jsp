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
    
    // Fetch advice for homepage (filtered by category, default to 'inspire')
    String category = "inspire"; // Set to default category 'inspire'
    String advice = adviceBean.getAdviceByCategory(category); // Assuming this function handles category-based advice
%>
<html>
    <head>
        <title>DailyDose - Home</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles.css" />
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <div class="container">
            <h1 class="app-title">DailyDose</h1>

            <%-- Advice Card from adviceSlip.jsp --%>
            <div class="card advice-card">
                <p class="advice-text">“<%= advice %>”</p>
                <form method="get" action="adviceSlip.jsp">
                    <button type="submit" class="refresh-btn">See More Advice</button>
                </form>
            </div>

            <%-- Weather Card --%>
            <div class="card weather-card">
                <h3>Current Weather</h3>
                <p id="weather">Detecting your location...</p>
                <form action="weather.jsp" method="post" class="refresh-form">
                    <button type="submit" class="refresh-btn">Search Location....</button>
                </form>
            </div>

            <%-- News Card --%>
            <div class="card news-card weather">
                <h3>Top News Headlines</h3>
                <ul>
                    <% for (NewsArticle article : articles) {%>
                    <li>
                        <a href="<%= article.getUrl()%>" target="_blank" class="news-link">
                            <%= article.getTitle()%>
                        </a><br/>
                        <small><%= article.getSource()%> - <%= article.getPublishedDate()%></small>
                    </li>
                    <% }%>
                </ul>
            </div>
        </div>        
        <script src="currentGeoLocation.js"></script>
        <jsp:include page="footer.jsp" />
    </body>
</html>

