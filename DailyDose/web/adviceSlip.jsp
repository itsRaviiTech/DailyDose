<%-- 
    Document   : adviceSlip
    Created on : 18 Jun 2025, 12:30:31 am
    Author     : User
--%>

<%@ page import="model.AdviceBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Get the selected category or query from the request
    String query = request.getParameter("category");
    if (query == null || query.isEmpty()) {
        query = "general"; // Default query if none is provided
    }

    // Instantiate the AdviceBean to fetch the filtered advice
    AdviceBean adviceBean = new AdviceBean(); 

    // Fetch filtered advice based on the category
    String advice = adviceBean.getAdviceByCategory(query); 
    // Set the advice as a request attribute so it can be accessed in the JSP
    request.setAttribute("advice", advice);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Filtered Advice</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles.css" />
</head>

<jsp:include page="header.jsp" />
<body>
    <!-- Main container -->
    <div class="container">
        <h1 class="app-title">DailyAdvice - <%= query %> Advice</h1>

        <!-- Category Selection Form -->
        <form method="get" action="adviceSlip.jsp">
            <label for="category">Select Category:</label>
            <select name="category" id="category">
                <option value="life" <%= query.equals("life") ? "selected" : "" %>>Life</option>
                <option value="happiness" <%= query.equals("happiness") ? "selected" : "" %>>Happiness</option>
                <option value="joy" <%= query.equals("joy") ? "selected" : "" %>>Joy</option>
                <option value="lesson" <%= query.equals("lesson") ? "selected" : "" %>>Lesson</option>
                <option value="experience" <%= query.equals("experience") ? "selected" : "" %>>Experience</option>
                <option value="work" <%= query.equals("work") ? "selected" : "" %>>Work</option>
                <option value
                        
                        regret" <%= query.equals("regret") ? "selected" : "" %>>Regrets?</option>
            </select>
            <button type="submit">Get Advice</button>
        </form>

        <!-- Display the advice -->
        <div class="card advice-card">
            <p class="advice-text">“<%= request.getAttribute("advice") %>”</p>
        </div>
    </div>
</body>

<jsp:include page="footer.jsp" />
</html>
