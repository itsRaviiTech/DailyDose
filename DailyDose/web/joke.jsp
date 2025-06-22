<%-- 
    Document   : joke
    Created on : 22 Jun 2025, 8:43:43 pm
    Author     : User
--%>

<%@ page import="model.JokeBean" %>
<%@ page import="java.util.List" %>

<%
    // Get the category and type from the request (with default values)
    String category = request.getParameter("category");
    if (category == null || category.isEmpty()) {
        category = "Any";  // Default category
    }
    String type = request.getParameter("type");
    if (type == null || type.isEmpty()) {
        type = "single";  // Default type
    }

    // Create an instance of JokeBean
    JokeBean jokeBean = new JokeBean();
    
    // Fetch a random joke based on the category and type
    jokeBean.fetchJoke(category, type);
    
    // Get the joke fetched by the bean
    String joke = jokeBean.getJoke();
%>

<html>
<head>
    <title>Joke of the Day</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f0f0f0;
            padding-top: 50px;
        }
        .joke-box {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 80%;
            max-width: 600px;
            margin: 0 auto;
        }
        h1 {
            color: #333;
        }
        p {
            font-size: 18px;
            color: #555;
        }
    </style>
</head>
<body>
    <div class="joke-box">
        <h1>Joke of the Day</h1>
        <p><%= joke %></p>
    </div>

    <div class="joke-options">
        <h2>Choose Your Joke Category:</h2>
        <form method="get" action="joke.jsp">
            <select name="category">
                <option value="Any" <%= category.equals("Any") ? "selected" : "" %>>Any</option>
                <option value="Programming" <%= category.equals("Programming") ? "selected" : "" %>>Programming</option>
                <option value="Miscellaneous" <%= category.equals("Miscellaneous") ? "selected" : "" %>>Miscellaneous</option>
                <option value="Puns" <%= category.equals("Puns") ? "selected" : "" %>>Puns</option>
                <option value="Spooky" <%= category.equals("Spooky") ? "selected" : "" %>>Spooky</option>
                <option value="Christmas" <%= category.equals("Christmas") ? "selected" : "" %>>Christmas</option>
            </select>

            <h3>Choose Joke Type:</h3>
            <select name="type">
                <option value="single" <%= type.equals("single") ? "selected" : "" %>>Single Part</option>
                <option value="twopart" <%= type.equals("twopart") ? "selected" : "" %>>Two Part</option>
            </select>

            <input type="submit" value="Get Joke" />
        </form>
    </div>
</body>
</html>
