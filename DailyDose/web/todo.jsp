<%-- 
    Document   : todo
    Created on : 23 Jun 2025, 12:49:42 am
    Author     : User
--%>

<%@page import="org.json.JSONObject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.TodoAPI" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.JSONArray" %>

<%
    // Create an instance of TodoAPI
    TodoAPI todoApi = new TodoAPI();
    String message = "";  // To store any success or error message for creating the task

    // Get the form data (title and completed status)
    String title = request.getParameter("title");
    String completedStr = request.getParameter("completed");
    boolean completed = completedStr != null && completedStr.equals("true");

    // If title is provided, create a new task
    if (title != null && !title.isEmpty()) {
        // Create the task using POST request
        JSONObject newTask = todoApi.createTask(title, completed);  // This returns a JSONObject

        // Fetch tasks from session or initialize an empty array
        JSONArray tasksArray = (JSONArray) session.getAttribute("tasks");
        if (tasksArray == null) {
            tasksArray = new JSONArray();  // Initialize if null
        }
        
        // Add the new task to the session
        tasksArray.put(newTask);  // Add new task to the array in session
        session.setAttribute("tasks", tasksArray);  // Update session with new task array

        message = "New Task Created: " + newTask.getString("title");  // Display the title of the created task
    }
%>

<html>
<head>
    <title>Add To-Do Task</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css" />
</head>
<body id="page-todo">
    <div class="container">
        <h1 class="app-title">Add New To-Do Task</h1>

        <!-- Display the message after task creation -->
        <div class="message">
            <p><%= message %></p>
        </div>

        <!-- Form to create a new task -->
        <form method="post" action="todo.jsp">
            <label for="title">Task Title:</label>
            <input type="text" name="title" id="title" required />

            <label for="completed">Completed:</label>
            <select name="completed" id="completed">
                <option value="true">Yes</option>
                <option value="false">No</option>
            </select>

            <button type="submit">Create Task</button>
        </form>       
    </div>

    <nav class="bottom-nav">
        <a href="index.jsp" class="nav-link">Home</a>
        <a href="weather.jsp" class="nav-link">Weather</a>
        <a href="news.jsp" class="nav-link">News</a>
    </nav>

    <script src="index.js"></script>
</body>
</html>
